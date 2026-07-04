import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../services/storage_services.dart';

class AuthController extends ChangeNotifier {
  final AuthServices _authService = AuthServices();
  final StorageService _storageService = StorageService();

  bool _isLoading = false;
  String? _error;
  String? _role;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get role => _role;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String role,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    if (name.isEmpty) {
      _error = "Name Required";
      notifyListeners();
      onError();
      return;
    }
    if (email.isEmpty) {
      _error = "Email Required";
      notifyListeners();
      onError();
      return;
    }
    if (password.isEmpty) {
      _error = "Password Required";
      notifyListeners();
      onError();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authService.register(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      if (result['success'] == true) {
        await _storageService.saveTokens(
          accessToken: result['accessToken'],
          refreshToken: result['refreshToken'],
        );
        await _storageService.saveRole(result['data']['role']);
        _role = result['data']['role'];
        onSuccess();
      } else {
        _error = result['message'];
        onError();
      }
    } catch (e) {
      _error = 'Something went wrong. Please try again.';
      onError();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    if (email.isEmpty) {
      _error = "Email Required";
      notifyListeners();
      onError();
      return;
    }
    if (password.isEmpty) {
      _error = "Password Required";
      notifyListeners();
      onError();
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authService.login(email: email, password: password);

      if (result['success'] == true) {
        await _storageService.saveTokens(
          accessToken: result['accessToken'],
          refreshToken: result['refreshToken'],
        );
        await _storageService.saveRole(result['data']['role']);
        _role = result['data']['role'];
        onSuccess();
      } else {
        _error = result['message'];
        onError();
      }
    } catch (e) {
      _error = 'Something went wrong. Please try again.';
      onError();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout({required VoidCallback onSuccess}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = _storageService.getAccessToken();
      if (token != null) {
        await _authService.logout(accessToken: token);
      }
      await _storageService.clearAll();
      _role = null;
      onSuccess();
    } catch (e) {
      await _storageService.clearAll();
      _role = null;
      onSuccess();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void isAuthenticated({
    required VoidCallback onAuthenticated,
    required VoidCallback onUnauthenticated,
  }) {
    final token = _storageService.getAccessToken();
    _role = _storageService.getRole();
    notifyListeners();

    if (token != null) {
      onAuthenticated();
    } else {
      onUnauthenticated();
    }
  }
}
