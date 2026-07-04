import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class UserServices {
  Future<Map<String, dynamic>> getServices() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/users/services'),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }
}
