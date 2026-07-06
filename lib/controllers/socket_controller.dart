import 'package:bookease/services/socket_services.dart';
import 'package:bookease/services/storage_services.dart';
import 'package:bookease/utils/animated_dialog.dart';
import 'package:bookease/utils/jwt_utils.dart';
import 'package:bookease/constants/api_constants.dart';
import 'package:flutter/material.dart';

class SocketController extends ChangeNotifier {
  final SocketServices _socketServices = SocketServices();
  final StorageService _storageService = StorageService();

  final GlobalKey<NavigatorState> navigatorKey;

  SocketController({required this.navigatorKey}) {
    connect();
  }

  void connect() {
    final token = _storageService.getAccessToken();
    if (token == null) return;

    final userId = JwtUtils.getUserId(token);
    if (userId == null) return;

    final baseUrl = ApiConstants.baseUrl.replaceAll('/api', '');

    _socketServices.connect(
      baseUrl,
      userId,
      _handleNewBooking,
      _handleBookingStatusUpdated,
    );
  }

  void disconnect() {
    _socketServices.disconnect();
  }

  void _handleNewBooking(dynamic data) {
    if (data == null) return;
    final message = data['message'] ?? 'You have a new booking.';

    _showDialog('New Booking!', message);
  }

  void _handleBookingStatusUpdated(dynamic data) {
    if (data == null) return;
    final message = data['message'] ?? 'Your booking status was updated.';

    _showDialog('Booking Update', message);
  }

  void _showDialog(String title, String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      showAnimatedDialog(context, title, message);
    }
  }
}
