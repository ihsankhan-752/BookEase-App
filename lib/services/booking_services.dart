import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class BookingServices {
  Future<Map<String, dynamic>> createBooking({
    required String accessToken,
    required String serviceId,
    required DateTime startTime,
    required DateTime endTime,
    required String notes,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/bookings'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'serviceId': serviceId,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'notes': notes,
      }),
    );

    print('Create Booking Status: ${response.statusCode}');
    print('Create Booking Body: ${response.body}');

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getUserBookings({
    required String accessToken,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/bookings/my'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    return jsonDecode(response.body);
  }
}
