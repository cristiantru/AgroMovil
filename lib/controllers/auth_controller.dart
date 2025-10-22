import 'package:flutter/material.dart';
import 'package:agromarket/models/user_model.dart';
import 'package:agromarket/services/firebase_service.dart';
import 'package:agromarket/services/microsoft_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  UserModel? _currentUser;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  AuthController() {
    // Escuchar cambios de autenticación
    FirebaseService.authStateChanges.listen((User? user) {
      if (user != null) {
        _loadUserData(user.uid);
      } else {
        _currentUser = null;
        _isLoggedIn = false;
        notifyListeners();
      }
    });
  }

  // ========== LOGIN Y REGISTRO ==========

  /// Login con Firebase Auth
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      print('🔐 AuthController: Iniciando login para $email');
      
      final result = await FirebaseService.signInWithEmail(
        email: email,
        password: password,
      );
      
      print('🔐 AuthController: Resultado del login: $result');
      
      if (result['success']) {
        _currentUser = UserModel.fromJson(result['user']);
        _isLoggedIn = true;
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError(result['message'] ?? 'Error desconocido en el login');
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ AuthController: Error inesperado: $e');
      _setError('Error inesperado: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  /// Registro con Firebase Auth
  Future<bool> register(String nombre, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      print('📝 AuthController: Iniciando registro para $email');
      
      final result = await FirebaseService.registerWithEmail(
        nombre: nombre,
        email: email,
        password: password,
      );
      
      print('📝 AuthController: Resultado del registro: $result');
      
      if (result['success']) {
        _currentUser = UserModel.fromJson(result['user']);
        _isLoggedIn = true;
        
        // Enviar email de verificación automáticamente
        print('📧 Enviando email de verificación automáticamente...');
        await sendEmailVerification();
        
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError(result['message'] ?? 'Error desconocido en el registro');
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ AuthController: Error inesperado: $e');
      _setError('Error inesperado: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // ========== MICROSOFT/HOTMAIL AUTH ==========

  /// Login con Microsoft/Hotmail
  Future<bool> loginWithMicrosoft(BuildContext context) async {
    _setLoading(true);
    _clearError();

    try {
      print('🔐 AuthController: Iniciando login con Microsoft');
      
      final microsoftUser = await MicrosoftAuthService.loginWithMicrosoft(context);
      
      if (microsoftUser != null) {
        print('✅ AuthController: Usuario de Microsoft obtenido: ${microsoftUser['email']}');
        
        // Registrar usuario de Microsoft en Firebase
        print('📝 AuthController: Registrando usuario de Microsoft en Firebase...');
        print('📧 Email recibido: ${microsoftUser['email']}');
        print('👤 Nombre recibido: ${microsoftUser['name']}');
        
        final registerResult = await FirebaseService.registerMicrosoftUser(
          nombre: microsoftUser['name'] ?? 'Usuario Microsoft',
          email: microsoftUser['email'] ?? '',
        );
        
        print('📊 AuthController: Resultado del registro: $registerResult');
        
        if (registerResult['success']) {
          _currentUser = UserModel.fromJson(registerResult['user']);
          print('✅ AuthController: Usuario Microsoft registrado en Firebase: ${_currentUser!.nombre}');
          print('🆔 ID del usuario: ${_currentUser!.id}');
          
          // Limpiar errores
          _clearError();
        } else {
          // Si falla el registro, crear usuario temporal
          _currentUser = UserModel(
            id: 'microsoft_${microsoftUser['email']?.hashCode ?? 'user'}',
            nombre: microsoftUser['name'] ?? 'Usuario Microsoft',
            email: microsoftUser['email'] ?? '',
          );
          print('⚠️ AuthController: Registro en Firebase falló, usando usuario temporal');
          print('❌ Error: ${registerResult['message']}');
          _setError('Usuario registrado localmente. Algunas funciones pueden estar limitadas.');
        }
        
        _isLoggedIn = true;
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError('No se pudo completar el login con Microsoft');
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ AuthController: Error en login con Microsoft: $e');
      _setError('Error en login con Microsoft: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // ========== VERIFICACIÓN DE EMAIL ==========

  /// Enviar email de verificación
  Future<bool> sendEmailVerification() async {
    _setLoading(true);
    _clearError();

    try {
      print('📧 AuthController: Enviando email de verificación');
      
      final result = await FirebaseService.sendEmailVerification();
      
      if (result['success']) {
        _setLoading(false);
        notifyListeners();
        print('✅ Email de verificación enviado');
        return true;
      } else {
        _setError(result['message']);
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ AuthController: Error enviando email de verificación: $e');
      _setError('Error enviando email de verificación: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // ========== RECUPERACIÓN DE CONTRASEÑA ==========

  /// Enviar email de recuperación de contraseña
  Future<bool> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    _clearError();

    try {
      print('AuthController: Enviando email de recuperación a $email');
      
      final result = await FirebaseService.sendPasswordResetEmail(email);
      
      print('AuthController: Resultado del envío: $result');
      
      if (result['success']) {
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError(result['message'] ?? 'Error enviando email de recuperación');
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('AuthController: Error inesperado: $e');
      _setError('Error inesperado: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // ========== UTILIDADES ==========


  /// Cargar datos del usuario desde Firebase
  Future<void> _loadUserData(String uid) async {
    try {
      final userData = await FirebaseService.getCurrentUserData();
      if (userData != null) {
        _currentUser = UserModel.fromJson(userData);
        _isLoggedIn = true;
        notifyListeners();
      }
    } catch (e) {
      print('❌ Error cargando datos del usuario: $e');
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await FirebaseService.signOut();
      _currentUser = null;
      _isLoggedIn = false;
      _clearError();
      notifyListeners();
    } catch (e) {
      print('❌ Error en logout: $e');
    }
  }

  /// Verificar estado de autenticación
  Future<void> checkAuthStatus() async {
    _setLoading(true);
    
    try {
      if (FirebaseService.isUserSignedIn()) {
        final userData = await FirebaseService.getCurrentUserData();
        if (userData != null) {
          _currentUser = UserModel.fromJson(userData);
          _isLoggedIn = true;
        }
      } else {
        _isLoggedIn = false;
        _currentUser = null;
      }
    } catch (e) {
      print('❌ Error verificando estado de autenticación: $e');
      _isLoggedIn = false;
      _currentUser = null;
    }
    
    _setLoading(false);
    notifyListeners();
  }

  /// Actualizar datos del usuario
  Future<bool> updateUserData(Map<String, dynamic> data) async {
    try {
      final success = await FirebaseService.updateUserData(data);
      if (success) {
        // Recargar datos del usuario
        await checkAuthStatus();
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Error actualizando datos del usuario: $e');
      return false;
    }
  }

  /// Verificar conexión a Firebase
  Future<bool> testConnection() async {
    return await FirebaseService.testConnection();
  }

  // ========== HELPERS ==========

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}