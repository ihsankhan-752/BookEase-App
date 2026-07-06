import 'package:bookease/controllers/booking_controller.dart';
import 'package:bookease/models/booking_model.dart';
import 'package:bookease/screens/service_provider/custom_navbar/bookings/widgets/info_card_widget.dart';
import 'package:bookease/screens/service_provider/custom_navbar/bookings/widgets/section_label_widget.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:bookease/widgets/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProviderBookingDetailsScreen extends StatelessWidget {
  final BookingModel booking;

  const ProviderBookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Booking Details',
          style: AppTextStyles.h2.copyWith(
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Customer Info ─────────────────────────
                    InfoCardWidget(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.1,
                            ),
                            child: Text(
                              booking.customerName.isNotEmpty
                                  ? booking.customerName[0].toUpperCase()
                                  : 'C',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.customerName.isNotEmpty
                                      ? booking.customerName
                                      : 'Customer',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  booking.customerEmail,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.chat_bubble_outline,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ─── Service Info ──────────────────────────
                    InfoCardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionLabelWidget(label: 'SERVICE'),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.build_circle_outlined,
                                color: AppColors.primary,
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
                                      '\$${booking.servicePrice.toStringAsFixed(2)} • ${booking.serviceDuration} mins',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor(
                                    booking.status,
                                  ).withValues(alpha: 0.1),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ─── Schedule ──────────────────────────────
                    InfoCardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionLabelWidget(label: 'SCHEDULE'),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat(
                                        'EEEE, MMM dd yyyy',
                                      ).format(booking.startTime),
                                      style: AppTextStyles.bodyLarge.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${DateFormat('hh:mm a').format(booking.startTime)} - ${DateFormat('hh:mm a').format(booking.endTime)}',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ─── Notes ─────────────────────────────────
                    if (booking.notes.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.sticky_note_2_outlined,
                                  color: Colors.black87,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Customer Notes',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '"${booking.notes}"',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.grey.shade800,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // ─── Bottom Actions ────────────────────────────────
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Consumer<BookingController>(
                builder: (context, bookingCtrl, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ─── Accept Button (pending only) ────────
                      if (booking.status == 'pending') ...[
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            title: "Accept Booking",
                            icon: Icons.check_circle_outline,
                            isLoading: bookingCtrl.isLoading,
                            onPressed: bookingCtrl.isLoading
                                ? null
                                : () {
                                    bookingCtrl.updateBookingStatus(
                                      bookingId: booking.id,
                                      status: 'active',
                                      onSuccess: () {
                                        showCustomMsg(
                                          context,
                                          'Booking Accepted',
                                        );
                                        Navigator.pop(context);
                                      },
                                      onError: () {
                                        showCustomMsg(
                                          context,
                                          bookingCtrl.error ??
                                              'Failed to accept',
                                        );
                                      },
                                    );
                                  },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // ─── Mark Complete (active only) ─────────
                      if (booking.status == 'active') ...[
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            title: "Mark as Complete",
                            icon: Icons.task_alt,
                            isLoading: bookingCtrl.isLoading,
                            onPressed: bookingCtrl.isLoading
                                ? null
                                : () {
                                    bookingCtrl.updateBookingStatus(
                                      bookingId: booking.id,
                                      status: 'complete',
                                      onSuccess: () {
                                        showCustomMsg(
                                          context,
                                          'Booking marked as complete',
                                        );
                                        Navigator.pop(context);
                                      },
                                      onError: () {
                                        showCustomMsg(
                                          context,
                                          bookingCtrl.error ??
                                              'Failed to update',
                                        );
                                      },
                                    );
                                  },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // ─── Cancel Button (pending or active) ───
                      if (booking.status == 'pending' ||
                          booking.status == 'active')
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: bookingCtrl.isLoading
                                ? null
                                : () {
                                    bookingCtrl.updateBookingStatus(
                                      bookingId: booking.id,
                                      status: 'cancelled',
                                      onSuccess: () {
                                        showCustomMsg(
                                          context,
                                          'Booking Cancelled',
                                        );
                                        Navigator.pop(context);
                                      },
                                      onError: () {
                                        showCustomMsg(
                                          context,
                                          bookingCtrl.error ??
                                              'Failed to cancel',
                                        );
                                      },
                                    );
                                  },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.redAccent),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.close,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Cancel Booking',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
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
        return Colors.green;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
