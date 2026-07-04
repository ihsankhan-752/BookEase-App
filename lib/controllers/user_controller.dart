import 'package:bookease/services/user_services.dart';
import 'package:flutter/material.dart';

import '../models/service_model.dart';

class UserController extends ChangeNotifier {
  final UserServices _services = UserServices();

  List<ServiceModel> _serviceList = [];
  bool _isLoading = false;
  String? _error;

  List<ServiceModel> get services => _serviceList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getAllServices({required VoidCallback onError}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _services.getServices();

      if (result['success'] == true) {
        _serviceList = (result['services'] as List)
            .map((s) => ServiceModel.fromJson(s))
            .toList();
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
}
