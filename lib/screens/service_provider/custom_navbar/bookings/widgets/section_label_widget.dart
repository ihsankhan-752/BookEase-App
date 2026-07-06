import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';

class SectionLabelWidget extends StatelessWidget {
  final String label;
  const SectionLabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.bodyMedium.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600,
        letterSpacing: 1.2,
      ),
    );
  }
}
