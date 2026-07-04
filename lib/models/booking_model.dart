class BookingModel {
  final String id;
  final String userId;
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

    return BookingModel(
      id: json['_id'] ?? '',
      userId: json['userId'] is Map
          ? json['userId']['_id'] ?? ''
          : json['userId'] ?? '',
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
      servicePrice: serviceField is Map
          ? (serviceField['price'] ?? 0).toDouble()
          : 0,
      serviceDuration: serviceField is Map
          ? (serviceField['duration'] ?? 0) is int
                ? serviceField['duration']
                : (serviceField['duration'] as num).toInt()
          : 0,
      startTime: DateTime.tryParse(json['startTime'] ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(json['endTime'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'active',
      paymentStatus: json['paymentStatus'] ?? 'unpaid',
      notes: json['notes'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
