import 'dart:convert';
import 'dart:io';

import 'package:bookease/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ServiceProviderServices {
  Future<Map<String, dynamic>> addService({
    required String accessToken,
    required String name,
    required String description,
    required int duration,
    required double price,
    File? image,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/serviceProvider');
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['duration'] = duration.toString();
    request.fields['price'] = price.toString();

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getMyServices({
    required String accessToken,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/serviceProvider'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return jsonDecode(response.body);
  }
}
