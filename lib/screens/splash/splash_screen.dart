import 'package:bookease/routes/app_routes.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/widgets/splash/splash_footer.dart';
import 'package:bookease/widgets/splash/splash_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const LogoWidget(),
            const SizedBox(height: 24),
            Text('BookEase', style: AppTextStyles.splashTitle),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                'Effortless service booking for your modern lifestyle.',
                textAlign: TextAlign.center,
                style: AppTextStyles.splashSubtitle,
              ),
            ),
            const Spacer(),
            const SplashFooter(),
          ],
        ),
      ),
    );
  }
}
