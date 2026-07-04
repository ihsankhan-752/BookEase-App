import 'package:flutter/material.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';

class BookingServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String providerName;
  final double rating;
  final String price;
  final String priceUnit;
  final Color imageColor;
  final String? imageUrl;
  final String? providerImageUrl;
  final VoidCallback? onTap;

  const BookingServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.providerName,
    required this.rating,
    required this.price,
    required this.priceUnit,
    this.imageColor = const Color(0xFFE2E8F0),
    this.imageUrl,
    this.providerImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: imageColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: imageUrl != null ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  ) : null,
                ),
                child: imageUrl == null ? const Center(
                  child: Icon(Icons.image_outlined, size: 48, color: Colors.black26),
                ) : null,
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_border_rounded, color: Colors.redAccent, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Content Area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: AppTextStyles.h2.copyWith(color: AppColors.primary, fontSize: 18),
                        ),
                        Text(
                          priceUnit,
                          style: AppTextStyles.bodyMedium.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Description
                Text(
                  description,
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                
                // Provider Row
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                        image: providerImageUrl != null ? DecorationImage(
                          image: NetworkImage(providerImageUrl!),
                          fit: BoxFit.cover,
                        ) : null,
                      ),
                      child: providerImageUrl == null ? const Icon(Icons.person_outline, size: 16, color: AppColors.primary) : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        providerName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: onTap ?? () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'View Details',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
