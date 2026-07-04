import 'package:bookease/controllers/auth_controller.dart';
import 'package:bookease/routes/app_routes.dart';
import 'package:bookease/screens/auth/login_screen.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/widgets/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderSettingsScreen extends StatelessWidget {
  const ProviderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Text('Settings', style: AppTextStyles.h1),
        const SizedBox(height: 24),

        _buildSettingsItem(
          icon: Icons.access_time,
          title: 'Availability',
          subtitle: 'Set your working hours',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.providerAvailability);
          },
        ),
        _buildSettingsItem(
          icon: Icons.person_outline,
          title: 'Profile Settings',
          subtitle: 'Update your information',
          onTap: () {},
        ),
        _buildSettingsItem(
          icon: Icons.payment,
          title: 'Payment Methods',
          subtitle: 'Manage your bank accounts',
          onTap: () {},
        ),
        _buildSettingsItem(
          icon: Icons.notifications_none,
          title: 'Notifications',
          subtitle: 'Configure your alerts',
          onTap: () {},
        ),
        _buildSettingsItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          subtitle: 'Get assistance',
          onTap: () {},
        ),
        const SizedBox(height: 32),

        Consumer<AuthController>(
          builder: (context, authController, child) {
            return LogOutButton(
              onPressed: () async {
                await authController.logout(
                  onSuccess: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: AppTextStyles.bodyMedium),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
