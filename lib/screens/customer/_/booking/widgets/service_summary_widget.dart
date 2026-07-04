import 'package:bookease/models/service_model.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_theme.dart';

class ServiceSummaryWidget extends StatelessWidget {
  final ServiceModel service;
  const ServiceSummaryWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              image: service.image.url != null && service.image.url!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(service.image.url!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: service.image.url == null || service.image.url!.isEmpty
                ? const Icon(Icons.home_repair_service, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        service.name,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      '\$${service.price.toStringAsFixed(2)}',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Duration: ${service.duration} mins',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_rounded,
                      color: Colors.redAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${service.averageRating.toStringAsFixed(1)} (${service.totalReviews} reviews)',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
