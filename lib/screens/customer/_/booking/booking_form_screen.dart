import 'package:bookease/screens/customer/_/booking/widgets/date_selector_widget.dart';
import 'package:bookease/screens/customer/_/booking/widgets/notes_widget.dart';
import 'package:bookease/screens/customer/_/booking/widgets/service_summary_widget.dart';
import 'package:bookease/screens/customer/_/booking/widgets/time_slot_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/booking_controller.dart';
import '../../../../models/service_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/show_custom_msg.dart';
import '../../../../widgets/shared/buttons.dart';

class BookingFormScreen extends StatefulWidget {
  final ServiceModel service;

  const BookingFormScreen({super.key, required this.service});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

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
          'Booking Form',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<BookingController>(
        builder: (context, booking, child) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ServiceSummaryWidget(service: widget.service),
                        const SizedBox(height: 32),

                        DateSelectorWidget(
                          dates: booking.dates,
                          selectedIndex: booking.selectedDateIndex,
                          onDateSelected: booking.selectDate,
                        ),
                        const SizedBox(height: 32),

                        TimeSlotWidget(
                          times: booking.times,
                          selectedIndex: booking.selectedTimeIndex,
                          onTimeSelected: booking.selectTime,
                        ),
                        const SizedBox(height: 32),

                        Text(
                          'Notes for Provider',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        NotesWidget(controller: _notesController),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: PrimaryButton(
                    title: "Confirm Booking",
                    icon: Icons.arrow_forward,
                    onPressed: booking.isLoading
                        ? null
                        : () {
                            booking.createBooking(
                              serviceId: widget.service.id,
                              durationMinutes: widget.service.duration,
                              notes: _notesController.text.trim(),
                              onSuccess: () {
                                showCustomMsg(
                                  context,
                                  'Booking Created Successfully',
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.dashboard,
                                );
                              },
                              onError: () {
                                showCustomMsg(
                                  context,
                                  booking.error ?? 'Failed to create booking',
                                );
                              },
                            );
                          },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
