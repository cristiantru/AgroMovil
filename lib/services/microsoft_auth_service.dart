import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class MicrosoftAuthService {
  static const String _clientId = 'f4c08380-6669-48ba-af2e-5b8ef6765b64'; // Client ID de Azure
  static const String _redirectUri = 'msauth://com.example.agromarket/oauth2redirect';
  static const String _authority = 'https://login.microsoftonline.com/common/oauth2/v2.0';
  static const String _scope = 'openid profile email User.Read';
  
  // Variables para PKCE
  static String? _codeVerifier;
  static String? _codeChallenge;

  static void _generatePKCE() {
    //generar codigo de verficacion
    final random = Random.secure();
    final bytes = List<int>.generate(32, (i) => random.nextInt(256));
    _codeVerifier = base64Url.encode(bytes).replaceAll('=', '');
    
    // Generar code challenge (SHA256 del code verifier)
    final digest = sha256.convert(utf8.encode(_codeVerifier!));
    _codeChallenge = base64Url.encode(digest.bytes).replaceAll('=', '');
    
    print('🔐 Code Verifier: $_codeVerifier');
    print('🔐 Code Challenge: $_codeChallenge');
  }

  // Obtener URL de autorización con PKCE
  static String getAuthorizationUrl() {
    _generatePKCE();
    
    final params = {
      'response_type': 'code',
      'client_id': _clientId,
      'redirect_uri': _redirectUri,
      'scope': _scope,
      'code_challenge': _codeChallenge!,
      'code_challenge_method': 'S256',
    };
    
    final uri = Uri.parse('$_authority/authorize').replace(queryParameters: params);
    return uri.toString();
  }

  // aqui se inicia rl proceso del login
  static Future<Map<String, dynamic>?> loginWithMicrosoft(BuildContext context) async {
    try {
      final authUrl = getAuthorizationUrl();
      print('🔗 URL de autorización: $authUrl');
      print('🔗 Redirect URI: $_redirectUri');
      
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MicrosoftLoginWebView(
            authUrl: authUrl,
            redirectUri: _redirectUri,
          ),
        ),
      );

      print('Resultado del WebView: $result');

      if (result != null && result['code'] != null) {
        print('Código recibido: ${result['code']}');
        final token = await _exchangeCodeForToken(result['code']);
        if (token != null) {
          print('Token obtenido: ${token.substring(0, 20)}...');

          final userInfo = await _getUserInfo(token);
          return userInfo;
        } else {
          print('No se pudo obtener el token');
        }
      } else if (result != null && result['error'] != null) {
        print('Error en OAuth: ${result['error']}');
      } else {
        print('Login cancelado por el usuario');
      }
      
      return null;
    } catch (e) {
      print('Error en login con Microsoft: $e');
      return null;
    }
  }

  // Intercambiar código de autorización por token de acceso usando HTTP directo con PKCE
  static Future<String?> _exchangeCodeForToken(String code) async {
    try {
      print('Intercambiando código por token...');
      print('Usando Code Verifier: $_codeVerifier');

      final tokenEndpoint = Uri.parse('$_authority/token');
      
      final response = await http.post(
        tokenEndpoint,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'client_id': _clientId,
          'code': code,
          'redirect_uri': _redirectUri,
          'grant_type': 'authorization_code',
          'code_verifier': _codeVerifier!,
          'scope': _scope,
        },
      );

      print('Respuesta del servidor: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        final tokenData = json.decode(response.body);
        final accessToken = tokenData['access_token'] as String?;
        
        if (accessToken != null) {
          print('Token obtenido exitosamente');
          return accessToken;
        } else {
          print('No se encontró access_token en la respuesta');
          return null;
        }
      } else {
        print('Error del servidor: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error intercambiando código por token: $e');
      return null;
    }
  }

  // Obtener información del usuario desde Microsoft Graph usando HTTP directo
  static Future<Map<String, dynamic>?> _getUserInfo(String accessToken) async {
    try {
      print('Obteniendo información del usuario...');
      
      final response = await http.get(
        Uri.parse('https://graph.microsoft.com/v1.0/me'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Respuesta de Graph API: ${response.statusCode}');
      print('Datos del usuario: ${response.body}');

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        return {
          'id': userData['id'],
          'name': userData['displayName'],
          'email': userData['mail'] ?? userData['userPrincipalName'],
          'accessToken': accessToken,
        };
      } else {
        print('Error obteniendo información del usuario: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error obteniendo información del usuario: $e');
      return null;
    }
  }
}

// Widget WebView para mostrar el login de Microsoft
class MicrosoftLoginWebView extends StatefulWidget {
  final String authUrl;
  final String redirectUri;

  const MicrosoftLoginWebView({
    super.key,
    required this.authUrl,
    required this.redirectUri,
  });

  @override
  State<MicrosoftLoginWebView> createState() => _MicrosoftLoginWebViewState();
}

class _MicrosoftLoginWebViewState extends State<MicrosoftLoginWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Detectar cuando se redirige al URI de callback
            if (request.url.startsWith(widget.redirectUri)) {
              _handleRedirect(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.authUrl));
  }

  void _handleRedirect(String url) {
    print('Redirección detectada: $url');
    final uri = Uri.parse(url);
    final code = uri.queryParameters['code'];
    final error = uri.queryParameters['error'];
    final errorDescription = uri.queryParameters['error_description'];

    print('Parámetros de la URL:');
    print('  - code: $code');
    print('  - error: $error');
    print('  - error_description: $errorDescription');

    if (code != null) {
      print('Código de autorización recibido');
      Navigator.pop(context, {'code': code});
    } else if (error != null) {
      print('Error en OAuth: $error - $errorDescription');
      Navigator.pop(context, {'error': error, 'description': errorDescription});
    } else {
      print('Login cancelado por el usuario');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión con Microsoft'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2E7D32),
              ),
            ),
        ],
      ),
    );
  }
}
