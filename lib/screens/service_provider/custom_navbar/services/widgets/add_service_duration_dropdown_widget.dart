import 'package:bookease/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AddServiceDurationDropdownWidget extends StatelessWidget {
  final String selectedDuration;
  final ValueChanged<String> onChanged;

  const AddServiceDurationDropdownWidget({
    super.key,
    required this.selectedDuration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duration',
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedDuration,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items:
                  [
                        '30 mins',
                        '1 hour',
                        '2 hours',
                        '3 hours',
                        '4 hours',
                        '5 hours',
                      ]
                      .map(
                        (val) => DropdownMenuItem(
                          value: val,
                          child: Text(val, style: AppTextStyles.bodyMedium),
                        ),
                      )
                      .toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
