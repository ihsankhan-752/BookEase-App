import 'package:bookease/controllers/booking_controller.dart';
import 'package:bookease/models/booking_model.dart';
import 'package:bookease/screens/customer/_/booking/widgets/booking_card_widget.dart';
import 'package:bookease/screens/customer/_/booking/widgets/no_booking_found_widget.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingController>().getUserBookings(
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'My Bookings',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.primary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<BookingController>(
        builder: (context, booking, child) {
          if (booking.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => context.read<BookingController>().getUserBookings(
              onError: () {
                showCustomMsg(
                  context,
                  context.read<BookingController>().error ?? 'Failed to load',
                );
              },
            ),
            child: _BookingList(bookings: booking.bookings),
          );
        },
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  final List<BookingModel> bookings;

  const _BookingList({required this.bookings});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return NoBookingFoundWidget();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return BookingCardWidget(booking: bookings[index]);
      },
    );
  }
}
