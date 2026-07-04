import 'package:bookease/controllers/booking_controller.dart';
import 'package:bookease/models/service_model.dart';
import 'package:bookease/routes/app_routes.dart';
import 'package:bookease/screens/customer/_/booking/widgets/notes_widget.dart';
import 'package:bookease/screens/customer/_/booking/widgets/service_summary_widget.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/shared/buttons.dart';

class BookingFormScreen extends StatefulWidget {
  final ServiceModel service;

  const BookingFormScreen({super.key, required this.service});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 0;
  final TextEditingController _notesController = TextEditingController();

  final List<DateTime> _dates = List.generate(
    7,
    (i) => DateTime.now().add(Duration(days: i)),
  );

  final List<String> _times = [
    '08:00 AM',
    '09:30 AM',
    '11:00 AM',
    '01:00 PM',
    '02:30 PM',
    '04:00 PM',
  ];

  DateTime _buildStartTime() {
    final selectedDate = _dates[_selectedDateIndex];
    final timeStr = _times[_selectedTimeIndex];
    final parts = timeStr.split(':');
    int hour = int.parse(parts[0]);
    final minParts = parts[1].split(' ');
    final minute = int.parse(minParts[0]);
    final isPM = minParts[1] == 'PM';
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );
  }

  DateTime _buildEndTime(DateTime startTime) {
    return startTime.add(Duration(minutes: widget.service.duration));
  }

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
      body: SafeArea(
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Date',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${_dates[0].month}/${_dates[0].year}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_dates.length, (index) {
                          final isSelected = index == _selectedDateIndex;
                          final date = _dates[index];
                          final days = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun',
                          ];
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedDateIndex = index),
                            child: Container(
                              width: 64,
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    days[date.weekday - 1],
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${date.day}',
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 32),

                    Text(
                      'Available Slots',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(_times.length, (index) {
                        final isSelected = index == _selectedTimeIndex;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedTimeIndex = index),
                          child: Container(
                            width:
                                (MediaQuery.of(context).size.width - 48 - 24) /
                                3,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.08)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.3)
                                    : Colors.grey.shade300,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _times[index],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
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

            Consumer<BookingController>(
              builder: (context, booking, child) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: PrimaryButton(
                    title: "Confirm Booking",
                    icon: Icons.arrow_forward,
                    onPressed: booking.isLoading
                        ? null
                        : () {
                            final startTime = _buildStartTime();
                            final endTime = _buildEndTime(startTime);

                            booking.createBooking(
                              serviceId: widget.service.id,
                              startTime: startTime,
                              endTime: endTime,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
