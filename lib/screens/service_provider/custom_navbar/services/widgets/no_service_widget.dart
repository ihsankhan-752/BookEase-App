import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';

class NoServiceWidget extends StatelessWidget {
  const NoServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Icon(
            Icons.home_repair_service_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No services yet',
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first service',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
