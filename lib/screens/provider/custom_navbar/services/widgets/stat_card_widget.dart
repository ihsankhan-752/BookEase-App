import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';

class StatCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color valueColor;

  const StatCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h1.copyWith(color: valueColor, fontSize: 28),
          ),
        ],
      ),
    );
  }
}
