import 'package:bookease/controllers/booking_controller.dart';
import 'package:bookease/models/booking_model.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProviderBookingsScreen extends StatefulWidget {
  const ProviderBookingsScreen({super.key});

  @override
  State<ProviderBookingsScreen> createState() => _ProviderBookingsScreenState();
}

class _ProviderBookingsScreenState extends State<ProviderBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingController>().getProviderBooking(
        onError: () {
          showCustomMsg(
            context,
            context.read<BookingController>().error ?? 'Failed to load',
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            left: 24.0,
            right: 24.0,
            bottom: 16.0,
          ),
          child: Text(
            'Manage Bookings',
            style: AppTextStyles.h2.copyWith(fontSize: 20),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'Incoming'),
                Tab(text: 'Confirmed'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: Consumer<BookingController>(
            builder: (context, booking, child) {
              if (booking.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final incoming = booking.bookings
                  .where((b) => b.status == 'pending')
                  .toList();
              final confirmed = booking.bookings
                  .where((b) => b.status == 'active')
                  .toList();
              final completed = booking.bookings
                  .where(
                    (b) => b.status == 'complete' || b.status == 'delivered',
                  )
                  .toList();

              return TabBarView(
                controller: _tabController,
                children: [
                  _buildList(
                    bookings: incoming,
                    emptyText: 'No incoming requests',
                  ),
                  _buildList(
                    bookings: confirmed,
                    emptyText: 'No confirmed bookings',
                  ),
                  _buildList(
                    bookings: completed,
                    emptyText: 'No completed bookings',
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildList({
    required List<BookingModel> bookings,
    required String emptyText,
  }) {
    if (bookings.isEmpty) {
      return Center(
        child: Text(
          emptyText,
          style: AppTextStyles.bodyLarge.copyWith(color: Colors.grey.shade600),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          context.read<BookingController>().getProviderBooking(onError: () {}),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ).copyWith(bottom: 80),
        children: bookings.map(_buildBookingCard).toList(),
      ),
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
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
              color: Colors.black.withOpacity(0.03),
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
                      errorBuilder: (_, __, ___) => _avatarPlaceholder(),
                    )
                  : _avatarPlaceholder(),
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
                color: _statusColor(booking.status).withOpacity(0.1),
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

  Widget _avatarPlaceholder() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: Colors.grey, size: 24),
    );
  }
}
