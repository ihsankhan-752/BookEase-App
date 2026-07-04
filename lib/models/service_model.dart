class ServiceImage {
  final String? publicId;
  final String? url;

  ServiceImage({this.publicId, this.url});

  factory ServiceImage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ServiceImage();
    return ServiceImage(publicId: json['public_id'], url: json['url']);
  }

  Map<String, dynamic> toJson() => {'public_id': publicId, 'url': url};
}

class ServiceModel {
  final String id;
  final String serviceProviderId;
  final String serviceProviderName;
  final String serviceProviderEmail;
  final String name;
  final String description;
  final int duration;
  final double price;
  final ServiceImage image;
  final bool isActive;
  final double averageRating;
  final int totalReviews;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceModel({
    required this.id,
    required this.serviceProviderId,
    this.serviceProviderName = '',
    this.serviceProviderEmail = '',
    required this.name,
    this.description = '',
    required this.duration,
    required this.price,
    ServiceImage? image,
    this.isActive = true,
    this.averageRating = 0,
    this.totalReviews = 0,
    required this.createdAt,
    required this.updatedAt,
  }) : image = image ?? ServiceImage();

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final providerField = json['serviceProvider'];
    final providerId = providerField is Map
        ? (providerField['_id'] ?? '')
        : (providerField ?? '');
    final providerName = providerField is Map
        ? (providerField['name'] ?? '')
        : '';
    final providerEmail = providerField is Map
        ? (providerField['email'] ?? '')
        : '';

    return ServiceModel(
      id: json['_id'] ?? '',
      serviceProviderId: providerId,
      serviceProviderName: providerName,
      serviceProviderEmail: providerEmail,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: (json['duration'] ?? 0) is int
          ? json['duration']
          : (json['duration'] as num).toInt(),
      price: (json['price'] ?? 0).toDouble(),
      image: ServiceImage.fromJson(json['image']),
      isActive: json['isActive'] ?? true,
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'serviceProvider': serviceProviderId,
    'name': name,
    'description': description,
    'duration': duration,
    'price': price,
    'image': image.toJson(),
    'isActive': isActive,
    'averageRating': averageRating,
    'totalReviews': totalReviews,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  Map<String, dynamic> toCreateJson() => {
    'name': name,
    'description': description,
    'duration': duration,
    'price': price,
  };

  ServiceModel copyWith({
    String? id,
    String? serviceProviderId,
    String? serviceProviderName,
    String? serviceProviderEmail,
    String? name,
    String? description,
    int? duration,
    double? price,
    ServiceImage? image,
    bool? isActive,
    double? averageRating,
    int? totalReviews,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      serviceProviderName: serviceProviderName ?? this.serviceProviderName,
      serviceProviderEmail: serviceProviderEmail ?? this.serviceProviderEmail,
      name: name ?? this.name,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
