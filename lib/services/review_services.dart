import 'dart:convert';

import 'package:bookease/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ReviewServices {
  Future<Map<String, dynamic>> createReview({
    required String accessToken,
    required String bookingId,
    required String review,
    required int rating,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/reviews'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'bookingId': bookingId,
        'review': review,
        'rating': rating,
      }),
    );

    print('Create Review Status: ${response.statusCode}');
    print('Create Review Body: ${response.body}');

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getServiceReviews({
    required String serviceId,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/reviews/$serviceId'),
      headers: {'Content-Type': 'application/json'},
    );

    print('Get Reviews Status: ${response.statusCode}');
    print('Get Reviews Body: ${response.body}');

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> deleteReview({
    required String accessToken,
    required String reviewId,
  }) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/api/reviews/$reviewId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return jsonDecode(response.body);
  }
}
