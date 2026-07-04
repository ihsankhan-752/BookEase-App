class BookingModel {
  final String id;
  final String userId;
  final String serviceProviderId;
  final String serviceId;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String paymentStatus;
  final String notes;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.serviceProviderId,
    required this.serviceId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.paymentStatus,
    required this.notes,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'] ?? '',
      userId: json['userId'] is Map
          ? json['userId']['_id'] ?? ''
          : json['userId'] ?? '',
      serviceProviderId: json['serviceProviderId'] is Map
          ? json['serviceProviderId']['_id'] ?? ''
          : json['serviceProviderId'] ?? '',
      serviceId: json['serviceId'] is Map
          ? json['serviceId']['_id'] ?? ''
          : json['serviceId'] ?? '',
      startTime: DateTime.tryParse(json['startTime'] ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(json['endTime'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'active',
      paymentStatus: json['paymentStatus'] ?? 'unpaid',
      notes: json['notes'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
