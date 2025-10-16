import 'package:flutter/material.dart';
import 'package:agromarket/models/user_model.dart';
import 'package:agromarket/services/api_service.dart';
import 'package:agromarket/services/microsoft_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  UserModel? _currentUser;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await ApiService.login(email, password);
      
      if (result['success']) {
        _currentUser = UserModel.fromJson(result['user']);
        _isLoggedIn = true;
        _setLoading(false);
        
        // Guardar datos de sesión
        await _saveUserSession(result['user']);
        
        notifyListeners();
        return true;
      } else {
        _setError(result['message']);
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _setError('Error inesperado: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String nombre, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await ApiService.register(nombre, email, password);
      
      if (result['success']) {
        _currentUser = UserModel.fromJson(result['user']);
        _isLoggedIn = true;
        _setLoading(false);
        
        // Guardar datos de sesión
        await _saveUserSession(result['user']);
        
        notifyListeners();
        return true;
      } else {
        _setError(result['message']);
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _setError('Error inesperado: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> socialLogin(Map<String, dynamic> userInfo) async {
    _setLoading(true);
    _clearError();

    try {
      final email = userInfo['email'] as String;
      final nombre = userInfo['name'] as String;
      
      // Intentar login primero
      final loginResult = await ApiService.login(email, 'social_login');
      if (loginResult['success']) {
        _currentUser = UserModel.fromJson(loginResult['user']);
        _isLoggedIn = true;
        _setLoading(false);
        await _saveUserSession(loginResult['user']);
        notifyListeners();
        return true;
      }

      // Si no existe se crea cuenta
      final registerResult = await ApiService.register(nombre, email, 'social_login');
      if (registerResult['success']) {
        _currentUser = UserModel.fromJson(registerResult['user']);
        _isLoggedIn = true;
        _setLoading(false);
        await _saveUserSession(registerResult['user']);
        notifyListeners();
        return true;
      }
      
      _setError('Error en login social');
      _setLoading(false);
      notifyListeners();
      return false;
    } catch (e) {
      _setError('Error en login social: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Login con Microsoft/Hotmail
  Future<bool> loginWithMicrosoft(BuildContext context) async {
    _setLoading(true);
    _clearError();

    try {
      final userInfo = await MicrosoftAuthService.loginWithMicrosoft(context);
      
      if (userInfo != null) {
        final email = userInfo['email'] as String;
        final nombre = userInfo['name'] as String;
        
        // Intentar login primero
        final loginResult = await ApiService.login(email, 'microsoft_login');
        if (loginResult['success']) {
          _currentUser = UserModel.fromJson(loginResult['user']);
          _isLoggedIn = true;
          _setLoading(false);
          await _saveUserSession(loginResult['user']);
          notifyListeners();
          return true;
        }

        // Si no existe se crea una cuenta
        final registerResult = await ApiService.register(nombre, email, 'microsoft_login');
        if (registerResult['success']) {
          _currentUser = UserModel.fromJson(registerResult['user']);
          _isLoggedIn = true;
          _setLoading(false);
          await _saveUserSession(registerResult['user']);
          notifyListeners();
          return true;
        }
        
        _setError('Error al procesar login con Microsoft');
        _setLoading(false);
        notifyListeners();
        return false;
      } else {
        _setError('Login con Microsoft cancelado');
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _setError('Error en login con Microsoft: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Cerrar sesion
  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    _clearError();
    await _clearUserSession();
    notifyListeners();
  }

  // Método para verificar si está logueado al iniciar la app
  Future<void> checkAuthStatus() async {
    _setLoading(true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      
      if (isLoggedIn) {
        final userId = prefs.getInt('user_id');
        final userName = prefs.getString('user_name');
        final userEmail = prefs.getString('user_email');
        
        if (userId != null && userName != null && userEmail != null) {
          _currentUser = UserModel(
            id: userId,
            nombre: userName,
            email: userEmail,
          );
          _isLoggedIn = true;
        } else {
          _isLoggedIn = false;
          _currentUser = null;
          await _clearUserSession();
        }
      } else {
        _isLoggedIn = false;
        _currentUser = null;
      }
    } catch (e) {
      _setError('Error al verificar autenticación: ${e.toString()}');
      _isLoggedIn = false;
      _currentUser = null;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

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

  Future<void> _saveUserSession(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userData['id']);
    await prefs.setString('user_name', userData['nombre']);
    await prefs.setString('user_email', userData['email']);
    await prefs.setBool('is_logged_in', true);
  }

  Future<void> _clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.setBool('is_logged_in', false);
  }
}
