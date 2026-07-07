class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String serviceId;
  final String bookingId;
  final String review;
  final int rating;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.userId,
    this.userName = '',
    required this.serviceId,
    required this.bookingId,
    required this.review,
    required this.rating,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final userField = json['userId'];
    return ReviewModel(
      id: json['_id'] ?? '',
      userId: userField is Map ? userField['_id'] ?? '' : userField ?? '',
      userName: userField is Map ? userField['name'] ?? '' : '',
      serviceId: json['serviceId'] ?? '',
      bookingId: json['bookingId'] ?? '',
      review: json['review'] ?? '',
      rating: json['rating'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
