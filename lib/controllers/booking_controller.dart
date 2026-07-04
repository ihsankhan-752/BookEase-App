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

  // ─── Date & Time State ────────────────────────
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  final List<DateTime> dates = List.generate(
    7,
    (i) => DateTime.now().add(Duration(days: i)),
  );

  final List<String> times = [
    '08:00 AM',
    '09:30 AM',
    '11:00 AM',
    '01:00 PM',
    '02:30 PM',
    '04:00 PM',
  ];

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ─── Select Date ──────────────────────────────
  void selectDate(int index) {
    selectedDateIndex = index;
    notifyListeners();
  }

  // ─── Select Time ──────────────────────────────
  void selectTime(int index) {
    selectedTimeIndex = index;
    notifyListeners();
  }

  // ─── Build Start Time ─────────────────────────
  DateTime buildStartTime() {
    final selectedDate = dates[selectedDateIndex];
    final timeStr = times[selectedTimeIndex];
    final parts = timeStr.split(':');
    int hour = int.parse(parts[0]);
    final minParts = parts[1].split(' ');
    final minute = int.parse(minParts[0]);
    final isPM = minParts[1] == 'PM';
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );
  }

  // ─── Build End Time ───────────────────────────
  DateTime buildEndTime(DateTime startTime, int durationMinutes) {
    return startTime.add(Duration(minutes: durationMinutes));
  }

  // ─── Create Booking ───────────────────────────
  Future<void> createBooking({
    required String serviceId,
    required int durationMinutes,
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

      final startTime = buildStartTime();
      final endTime = buildEndTime(startTime, durationMinutes);

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
      print('API RESPONSE: $result');

      if (result['success'] == true) {
        print('RAW BOOKINGS COUNT: ${(result['bookings'] as List).length}');
        _bookings = (result['bookings'] as List).map((b) {
          try {
            return BookingModel.fromJson(b);
          } catch (e, st) {
            print('PARSE ERROR on booking: $b');
            print('ERROR: $e');
            print(st);
            rethrow;
          }
        }).toList();
        print('PARSED BOOKINGS COUNT: ${_bookings.length}');
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
