import 'dart:convert';

import 'package:bookease/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> logout({required String accessToken}) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/users/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getMe({required String accessToken}) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return jsonDecode(response.body);
  }
}
