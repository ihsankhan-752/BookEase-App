import 'package:bookease/routes/app_routes.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/widgets/shared/buttons.dart';
import 'package:bookease/widgets/shared/text_inputs.dart';
import 'package:bookease/widgets/splash/splash_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/socket_controller.dart';
import '../../utils/show_custom_msg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              LogoWidget(),
              const SizedBox(height: 12),
              Text(
                'Your gateway to seamless lifestyle services.',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back', style: AppTextStyles.h2),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'name@example.com',
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: '••••••••',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),
                    Consumer<AuthController>(
                      builder: (context, auth, child) {
                        return PrimaryButton(
                          title: 'Login',
                          icon: Icons.arrow_forward,
                          isLoading: auth.isLoading,
                          onPressed: auth.isLoading
                              ? null
                              : () {
                                  auth.login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),

                                    onSuccess: () {
                                      Provider.of<SocketController>(context, listen: false).connect();
                                      final role = auth.role;
                                      if (role == 'serviceProvider') {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.providerDashboard,
                                        );
                                      } else {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.dashboard,
                                        );
                                      }
                                    },
                                    onError: () {
                                      showCustomMsg(
                                        context,
                                        auth.error ?? 'Login failed',
                                      );
                                    },
                                  );
                                },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Bottom Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: Text(
                      'Register now',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
