class BookingModel {
  final String id;
  final String userId;
  final String customerName;
  final String customerEmail;
  final String serviceProviderId;
  final String serviceProviderName;
  final String serviceId;
  final String serviceName;
  final String serviceImage;
  final double servicePrice;
  final int serviceDuration;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String paymentStatus;
  final String notes;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.userId,
    this.customerName = '',
    this.customerEmail = '',
    required this.serviceProviderId,
    this.serviceProviderName = '',
    required this.serviceId,
    this.serviceName = '',
    this.serviceImage = '',
    this.servicePrice = 0,
    this.serviceDuration = 0,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.paymentStatus,
    required this.notes,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final serviceField = json['serviceId'];
    final providerField = json['serviceProviderId'];
    final userField = json['userId'];

    return BookingModel(
      id: json['_id'] ?? '',
      userId: userField is Map ? userField['_id'] ?? '' : userField ?? '',
      customerName: userField is Map ? userField['name'] ?? '' : '',
      customerEmail: userField is Map ? userField['email'] ?? '' : '',
      serviceProviderId: providerField is Map
          ? providerField['_id'] ?? ''
          : providerField ?? '',
      serviceProviderName: providerField is Map
          ? providerField['name'] ?? ''
          : '',
      serviceId: serviceField is Map
          ? serviceField['_id'] ?? ''
          : serviceField ?? '',
      serviceName: serviceField is Map ? serviceField['name'] ?? '' : '',
      serviceImage: serviceField is Map && serviceField['image'] is Map
          ? (serviceField['image']['url'] ?? '')
          : '',
      servicePrice: serviceField is Map && serviceField['price'] != null
          ? (serviceField['price'] as num)
                .toDouble() // ✅ safe cast
          : 0.0,
      serviceDuration: serviceField is Map && serviceField['duration'] != null
          ? (serviceField['duration'] as num).toInt()
          : 0,
      startTime: DateTime.tryParse(json['startTime'] ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(json['endTime'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'pending',
      paymentStatus: json['paymentStatus'] ?? 'unpaid',
      notes: json['notes'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
