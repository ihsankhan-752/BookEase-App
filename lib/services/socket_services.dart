import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServices {
  IO.Socket? _socket;

  void connect(
      String url,
      String userId,
      Function(dynamic) onNewBooking,
      Function(dynamic) onBookingStatusUpdated) {
    if (_socket != null && _socket!.connected) return;

    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.connect();

    _socket!.onConnect((_) {
      print('Socket Connected');
      _socket!.emit('join', userId);
    });

    _socket!.on('new_booking', (data) {
      onNewBooking(data);
    });

    _socket!.on('booking_status_updated', (data) {
      onBookingStatusUpdated(data);
    });

    _socket!.onDisconnect((_) => print('Socket disconnected'));
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}
