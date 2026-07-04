import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String company;
  final double rating;
  final int reviewCount;
  final String price;
  final String priceUnit;
  final Color imageColor;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.company,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.priceUnit,
    this.imageColor = const Color(0xFFE2E8F0),
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: imageColor,
                    borderRadius: BorderRadius.circular(16),
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageUrl == null
                      ? const Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: Colors.black26,
                          ),
                        )
                      : null,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Title and Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  price,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Company and Unit Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(company, style: AppTextStyles.bodyMedium),
                Text(
                  priceUnit,
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Rating Row
            Row(
              children: [
                const Icon(
                  Icons.star_border_rounded,
                  color: Colors.redAccent,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '($reviewCount)',
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
