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
    required String category,
    File? image,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/serviceProvider');
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['duration'] = duration.toString();
    request.fields['price'] = price.toString();
    request.fields['category'] = category;

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

  Future<Map<String, dynamic>> deleteService({
    required String accessToken,
    required String serviceId,
  }) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/serviceProvider/$serviceId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> updateService({
    required String accessToken,
    required String serviceId,
    String? name,
    String? description,
    int? duration,
    double? price,
    String? category,
    File? image,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/serviceProvider/$serviceId');
    final request = http.MultipartRequest('PATCH', uri);

    request.headers['Authorization'] = 'Bearer $accessToken';

    if (name != null) request.fields['name'] = name;
    if (description != null) request.fields['description'] = description;
    if (duration != null) request.fields['duration'] = duration.toString();
    if (price != null) request.fields['price'] = price.toString();
    if (category != null) request.fields['category'] = category;

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Update Status: ${response.statusCode}');
    print('Update Body: ${response.body}');

    return jsonDecode(response.body);
  }
}
