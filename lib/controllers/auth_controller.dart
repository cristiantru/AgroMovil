import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = true; // Siempre logueado para simplicidad
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  // Método simplificado para simular login
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    // Simular proceso de login
    await Future.delayed(const Duration(seconds: 1));
    
    _isLoggedIn = true;
    _setLoading(false);
    notifyListeners();
    return true;
  }

  // Método simplificado para simular registro
  Future<bool> register(String nombre, String email, String password) async {
    _setLoading(true);
    _clearError();

    // Simular proceso de registro
    await Future.delayed(const Duration(seconds: 1));
    
    _isLoggedIn = true;
    _setLoading(false);
    notifyListeners();
    return true;
  }

  // Método simplificado para logout
  Future<void> logout() async {
    _isLoggedIn = false;
    _clearError();
    notifyListeners();
  }

  // Método para verificar estado de autenticación
  Future<void> checkAuthStatus() async {
    _setLoading(true);
    
    // Simular verificación
    await Future.delayed(const Duration(milliseconds: 500));
    
    _isLoggedIn = true;
    _setLoading(false);
    notifyListeners();
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
}