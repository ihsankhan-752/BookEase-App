import 'package:flutter/material.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';

class SplashFooter extends StatelessWidget {
  const SplashFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(isActive: true),
            const SizedBox(width: 8),
            _buildDot(isActive: false),
            const SizedBox(width: 8),
            _buildDot(isActive: false),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'SERVICEHUB ECOSYSTEM',
          style: AppTextStyles.splashFooter,
        ),
        const SizedBox(height: 48), // Padding from bottom edge
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.white : AppColors.whiteFaded,
      ),
    );
  }
}
