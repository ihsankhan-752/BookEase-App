import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';

class NotesWidget extends StatelessWidget {
  final TextEditingController controller;
  const NotesWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Share any specific instructions or requirements...',
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.grey.shade500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
