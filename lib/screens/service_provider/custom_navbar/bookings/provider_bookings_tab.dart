import 'package:bookease/controllers/booking_controller.dart';
import 'package:bookease/screens/service_provider/custom_navbar/bookings/widgets/build_booking_list.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:flutter/material.dart';
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
            style: AppTextStyles.h2.copyWith(
              fontSize: 20,
              color: AppColors.primary,
            ),
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
                  BookingListWidget(
                    bookings: incoming,
                    emptyText: 'No incoming requests',
                  ),
                  BookingListWidget(
                    bookings: confirmed,
                    emptyText: 'No confirmed bookings',
                  ),
                  BookingListWidget(
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
}
