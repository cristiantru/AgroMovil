import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.0.108:3000/api';
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
  };

  // Login de usuario
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('🔐 Intentando login con email: $email');
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Respuesta del servidor: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('Login exitoso: $result');
        return result;
      } else {
        final errorBody = jsonDecode(response.body);
        print('Error del servidor: ${errorBody['message']}');
        return {
          'success': false,
          'message': errorBody['message'] ?? 'Error del servidor: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Error en login API: $e');
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }

  // Registro de usuario
  static Future<Map<String, dynamic>> register(String nombre, String email, String password) async {
    try {
      print('📝 Intentando registro con email: $email');
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: _headers,
        body: jsonEncode({
          'nombre': nombre,
          'email': email,
          'password': password,
        }),
      );

      print('Respuesta del servidor: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('Registro exitoso: $result');
        return result;
      } else {
        final errorBody = jsonDecode(response.body);
        print('Error del servidor: ${errorBody['message']}');
        return {
          'success': false,
          'message': errorBody['message'] ?? 'Error del servidor: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Error en registro API: $e');
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }

  // Test de conexión
  static Future<bool> testConnection() async {
    try {
      print('Probando conexión con el servidor...');
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: _headers,
      );
      print('Respuesta del test: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error en test de conexión API: $e');
      return false;
    }
  }

  // Test de conexión con endpoint de login
  static Future<bool> testServerConnection() async {
    try {
      print('Probando conexión con el servidor usando login...');
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: _headers,
        body: jsonEncode({
          'email': 'test@test.com',
          'password': 'test123',
        }),
      );
      print('Respuesta del servidor: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');
      return response.statusCode == 200 || response.statusCode == 400; // 400 es esperado para credenciales incorrectas
    } catch (e) {
      print('Error conectando al servidor: $e');
      return false;
    }
  }
}
