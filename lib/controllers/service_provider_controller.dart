import 'dart:io';

import 'package:bookease/services/service_provider_services.dart';
import 'package:flutter/material.dart';

import '../models/service_model.dart';
import '../services/storage_services.dart';

class ServiceController extends ChangeNotifier {
  final ServiceProviderServices _serviceServices = ServiceProviderServices();
  final StorageService _storageService = StorageService();

  List<ServiceModel> _services = [];
  bool _isLoading = false;
  String? _error;

  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> createService({
    required String name,
    required String description,
    required int duration,
    required double price,
    File? image,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    if (name.isEmpty) {
      _error = 'Service name is required';
      notifyListeners();
      onError();
      return;
    }
    if (description.isEmpty) {
      _error = 'Description is required';
      notifyListeners();
      onError();
      return;
    }
    if (price <= 0) {
      _error = 'Price must be greater than 0';
      notifyListeners();
      onError();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = _storageService.getAccessToken();
      if (token == null) {
        _error = 'Not authenticated';
        onError();
        return;
      }

      final result = await _serviceServices.addService(
        accessToken: token,
        name: name,
        description: description,
        duration: duration,
        price: price,
        image: image,
      );

      if (result['success'] == true) {
        final newService = ServiceModel.fromJson(result['service']);
        _services.insert(0, newService);
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

  Future<void> getMyServices({required VoidCallback onError}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = _storageService.getAccessToken();
      if (token == null) {
        _error = 'Not authenticated';
        onError();
        return;
      }

      final result = await _serviceServices.getMyServices(accessToken: token);

      if (result['success'] == true) {
        _services = (result['services'] as List)
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

  Future<void> deleteService({
    required String serviceId,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = _storageService.getAccessToken();
      if (token == null) {
        _error = 'Not authenticated';
        onError();
        return;
      }

      final result = await _serviceServices.deleteService(
        accessToken: token,
        serviceId: serviceId,
      );

      if (result['success'] == true) {
        _services.removeWhere((s) => s.id == serviceId);
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
}
