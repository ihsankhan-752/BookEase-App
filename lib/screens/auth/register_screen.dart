import 'package:bookease/routes/app_routes.dart';
import 'package:bookease/screens/auth/widgets/terms_and_condition_widget.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:bookease/widgets/auth/role_toggle.dart';
import 'package:bookease/widgets/shared/buttons.dart';
import 'package:bookease/widgets/shared/text_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isCustomer = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'BookEase',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.primary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Create Account', style: AppTextStyles.h1),
            const SizedBox(height: 8),
            Text(
              'Join our community of professionals and service seekers today.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Are you a customer or a service provider?',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            RoleToggle(
              isCustomer: _isCustomer,
              onChanged: (val) {
                setState(() {
                  _isCustomer = val;
                });
              },
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _nameController,
              label: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _emailController,
              label: 'Email Address',
              hintText: 'email@example.com',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              label: 'Password',
              hintText: 'Create a strong password',
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 32),
            Consumer<AuthController>(
              builder: (context, auth, child) {
                return PrimaryButton(
                  text: 'Sign Up',
                  icon: Icons.arrow_forward,
                  isLoading: auth.isLoading,
                  onPressed: auth.isLoading
                      ? null
                      : () {
                          auth.register(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            role: _isCustomer ? 'user' : 'serviceProvider',
                            onSuccess: () {
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
                                auth.error ?? 'Registration failed',
                              );
                            },
                          );
                        },
                );
              },
            ),
            const SizedBox(height: 16),
            const TermsAndConditionWidget(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: AppTextStyles.bodyMedium,
                ),
                GestureDetector(
                  onTap: () {
                    // Assuming login is the previous screen in the stack
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: Text(
                    'Login',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
