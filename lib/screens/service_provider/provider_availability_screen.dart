import 'package:flutter/material.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';

class ProviderAvailabilityScreen extends StatefulWidget {
  const ProviderAvailabilityScreen({super.key});

  @override
  State<ProviderAvailabilityScreen> createState() => _ProviderAvailabilityScreenState();
}

class _ProviderAvailabilityScreenState extends State<ProviderAvailabilityScreen> {
  // Using simplified state for mockup
  bool mondayAvailable = true;
  bool tuesdayAvailable = false;
  bool wednesdayAvailable = true;
  bool thursdayAvailable = false;
  bool fridayAvailable = true;

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
          'Availability',
          style: AppTextStyles.h2.copyWith(fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
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
                    Text('Set your working hours', style: AppTextStyles.h1.copyWith(fontSize: 24)),
                    const SizedBox(height: 8),
                    Text(
                      'Configure your standard weekly schedule. Customers will see these slots as available for booking.',
                      style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade700, height: 1.5),
                    ),
                    const SizedBox(height: 32),

                    // Monday
                    _buildDayCard(
                      dayCode: 'MON',
                      dayName: 'Monday',
                      isAvailable: mondayAvailable,
                      onToggle: (val) => setState(() => mondayAvailable = val),
                      slots: [
                        _buildTimeSlot('09:00 AM', '05:00 PM'),
                      ],
                      showAddSlot: true,
                    ),

                    // Tuesday
                    _buildDayCard(
                      dayCode: 'TUE',
                      dayName: 'Tuesday',
                      isAvailable: tuesdayAvailable,
                      onToggle: (val) => setState(() => tuesdayAvailable = val),
                    ),

                    // Wednesday
                    _buildDayCard(
                      dayCode: 'WED',
                      dayName: 'Wednesday',
                      isAvailable: wednesdayAvailable,
                      onToggle: (val) => setState(() => wednesdayAvailable = val),
                      slots: [
                        _buildTimeSlot('10:00 AM', '06:00 PM'),
                      ],
                    ),

                    // Grid for Thu/Fri
                    Row(
                      children: [
                        Expanded(
                          child: _buildSmallDayCard(
                            dayCode: 'THU',
                            isAvailable: thursdayAvailable,
                            onToggle: (val) => setState(() => thursdayAvailable = val),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSmallDayCard(
                            dayCode: 'FRI',
                            isAvailable: fridayAvailable,
                            onToggle: (val) => setState(() => fridayAvailable = val),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Weekends
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.weekend_outlined, color: Colors.red.shade700),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Weekends (Sat - Sun)', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('Currently closed', style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Open', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Update Schedule', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.save_outlined, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard({
    required String dayCode,
    required String dayName,
    required bool isAvailable,
    required ValueChanged<bool> onToggle,
    List<Widget> slots = const [],
    bool showAddSlot = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isAvailable ? AppColors.primary.withOpacity(0.15) : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  dayCode,
                  style: TextStyle(
                    color: isAvailable ? AppColors.primary : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dayName, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      isAvailable ? 'Available' : 'Unavailable',
                      style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isAvailable,
                onChanged: onToggle,
                activeColor: AppColors.primary,
              ),
            ],
          ),
          if (isAvailable && slots.isNotEmpty) ...[
            const SizedBox(height: 20),
            ...slots,
          ],
          if (isAvailable && showAddSlot) ...[
            const SizedBox(height: 16),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text('Add another slot', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String start, String end) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(start, style: AppTextStyles.bodyMedium),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text('to', style: TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(end, style: AppTextStyles.bodyMedium),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.delete_outline, color: Colors.redAccent),
      ],
    );
  }

  Widget _buildSmallDayCard({
    required String dayCode,
    required bool isAvailable,
    required ValueChanged<bool> onToggle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(dayCode, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            isAvailable ? 'Available' : 'Unavailable',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 16),
          Switch(
            value: isAvailable,
            onChanged: onToggle,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
