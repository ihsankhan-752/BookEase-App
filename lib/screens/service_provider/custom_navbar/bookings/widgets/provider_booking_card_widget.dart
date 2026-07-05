import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../models/booking_model.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_theme.dart';
import 'avatar_placeholder_widget.dart';

Widget providerBookingCardWidget(BuildContext context, BookingModel booking) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(
        context,
        '/provider_booking_details',
        arguments: booking.id,
      );
    },
    borderRadius: BorderRadius.circular(16),
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: booking.serviceImage.isNotEmpty
                ? Image.network(
                    booking.serviceImage,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => avatarPlaceholder(),
                  )
                : avatarPlaceholder(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.serviceName,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${booking.servicePrice.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateFormat('MMM d, yyyy').format(booking.startTime)} • ${DateFormat('h:mm a').format(booking.startTime)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor(booking.status).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              booking.status.toUpperCase(),
              style: TextStyle(
                color: _statusColor(booking.status),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Color _statusColor(String status) {
  switch (status) {
    case 'pending':
      return Colors.orange;
    case 'active':
      return Colors.blue;
    case 'complete':
    case 'delivered':
      return Colors.green;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
