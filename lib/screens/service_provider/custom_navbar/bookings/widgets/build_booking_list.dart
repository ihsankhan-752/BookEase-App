import 'package:bookease/screens/service_provider/custom_navbar/bookings/widgets/provider_booking_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../controllers/booking_controller.dart';
import '../../../../../models/booking_model.dart';
import '../../../../../theme/app_theme.dart';

class BookingListWidget extends StatelessWidget {
  final List<BookingModel> bookings;
  final String emptyText;

  const BookingListWidget({
    super.key,
    required this.bookings,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
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
        children: bookings
            .map((booking) => providerBookingCardWidget(context, booking))
            .toList(),
      ),
    );
  }
}
