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

class _ProviderBookingsScreenState extends State<ProviderBookingsScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = ['Pending', 'Active', 'Complete', 'Cancelled'];

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            left: 24.0,
            right: 24.0,
            bottom: 16.0,
          ),
          child: Center(
            child: Text(
              'Manage Bookings',
              style: AppTextStyles.h2.copyWith(
                fontSize: 20,
                color: AppColors.primary,
              ),
            ),
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final isSelected = index == _selectedTab;
              return GestureDetector(
                onTap: () => setState(() => _selectedTab = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: Consumer<BookingController>(
            builder: (context, booking, child) {
              if (booking.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final lists = [
                booking.bookings.where((b) => b.status == 'pending').toList(),
                booking.bookings.where((b) => b.status == 'active').toList(),
                booking.bookings
                    .where(
                      (b) => b.status == 'complete' || b.status == 'delivered',
                    )
                    .toList(),
                booking.bookings.where((b) => b.status == 'cancelled').toList(),
              ];

              final emptyTexts = [
                'No pending requests',
                'No active bookings',
                'No completed bookings',
                'No cancelled bookings',
              ];

              return BookingListWidget(
                bookings: lists[_selectedTab],
                emptyText: emptyTexts[_selectedTab],
              );
            },
          ),
        ),
      ],
    );
  }
}
