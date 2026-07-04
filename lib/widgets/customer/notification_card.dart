import 'package:flutter/material.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';

class NotificationCard extends StatelessWidget {
  final Widget iconContent;
  final Color iconBackgroundColor;
  final String title;
  final String time;
  final String message;
  final bool isUnread;
  final bool isMessageItalic;
  final List<Widget>? actions;

  const NotificationCard({
    super.key,
    required this.iconContent,
    required this.iconBackgroundColor,
    required this.title,
    required this.time,
    required this.message,
    this.isUnread = false,
    this.isMessageItalic = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isUnread) Container(width: 4, color: AppColors.primary),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: iconBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: iconContent),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  time,
                                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 11, color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontStyle: isMessageItalic ? FontStyle.italic : FontStyle.normal,
                              ),
                            ),
                            if (actions != null && actions!.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Row(
                                children: actions!,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
