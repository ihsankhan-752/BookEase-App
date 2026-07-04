import 'package:flutter/material.dart';

import '../models/booking_model.dart';
import '../services/booking_services.dart';
import '../services/storage_services.dart';

class BookingController extends ChangeNotifier {
  final BookingServices _bookingServices = BookingServices();
  final StorageService _storageService = StorageService();

  List<BookingModel> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> createBooking({
    required String serviceId,
    required DateTime startTime,
    required DateTime endTime,
    required String notes,
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

      final result = await _bookingServices.createBooking(
        accessToken: token,
        serviceId: serviceId,
        startTime: startTime,
        endTime: endTime,
        notes: notes,
      );

      if (result['success'] == true) {
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

  Future<void> getUserBookings({required VoidCallback onError}) async {
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

      final result = await _bookingServices.getUserBookings(accessToken: token);

      if (result['success'] == true) {
        _bookings = (result['bookings'] as List)
            .map((b) => BookingModel.fromJson(b))
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
