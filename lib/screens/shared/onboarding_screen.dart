import 'package:bookease/routes/app_routes.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/widgets/shared/buttons.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Find Best Services',
      'subtitle':
          'Choose from thousands of professional providers for any task.',
      'icon': Icons.cleaning_services_rounded,
      'badges': [
        {
          'text': 'Verified Pro',
          'sub': 'Background Checked',
          'icon': Icons.verified_outlined,
          'top': null,
          'bottom': 20.0,
          'left': 20.0,
          'right': null,
        },
      ],
    },
    {
      'title': 'Expert Assistance',
      'subtitle':
          'Connect with certified tutors and fitness coaches instantly. Professional growth and wellness, just a tap away.',
      'icon': Icons.laptop_mac_rounded,
      'badges': [
        {
          'text': 'Expert Tutor',
          'sub': null,
          'icon': Icons.school_outlined,
          'top': null,
          'bottom': 40.0,
          'left': 10.0,
          'right': null,
          'isRed': true,
        },
        {
          'text': 'Certified Coach',
          'sub': null,
          'icon': Icons.fitness_center_rounded,
          'top': 20.0,
          'bottom': null,
          'left': null,
          'right': 10.0,
          'isBlue': true,
        },
      ],
    },
    {
      'title': 'Easy Booking',
      'subtitle':
          'Schedule services at your convenience with a few taps. Reliable pros are ready when you are.',
      'icon': Icons.plumbing_rounded,
      'badges': [
        {
          'text': 'Top Rated',
          'sub': null,
          'icon': Icons.star_border_rounded,
          'top': null,
          'bottom': 20.0,
          'left': -20.0,
          'right': null,
          'isRed': true,
        },
        {
          'text': 'Available Today',
          'sub': null,
          'icon': Icons.calendar_today_outlined,
          'top': 20.0,
          'bottom': null,
          'left': null,
          'right': -20.0,
          'isBlue': true,
        },
      ],
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage == 2)
                    Text(
                      'BookEase',
                      style: AppTextStyles.h2.copyWith(
                        color: AppColors.primary,
                      ),
                    )
                  else if (_currentPage == 0)
                    Row(
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          height: 4,
                          width: _currentPage == index ? 24 : 16,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppColors.primary
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 40),

                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      'Skip',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Bottom Navigation Area
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildBottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> pageData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image / Illustration Container with Badges
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      pageData['icon'],
                      size: 100,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
                // Badges
                ...((pageData['badges'] as List).map((badge) {
                  return Positioned(
                    top: badge['top'],
                    bottom: badge['bottom'],
                    left: badge['left'],
                    right: badge['right'],
                    child: _buildBadge(badge),
                  );
                })),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Texts
          Text(
            pageData['title'],
            style: AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            pageData['subtitle'],
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(Map<String, dynamic> badge) {
    Color iconColor = AppColors.primary;
    if (badge['isRed'] == true) iconColor = Colors.redAccent;
    if (badge['isBlue'] == true) iconColor = Colors.blueAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(badge['icon'], size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                badge['text'],
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              if (badge['sub'] != null) ...[
                const SizedBox(height: 2),
                Text(
                  badge['sub'],
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 10),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    if (_currentPage == 0) {
      return Column(
        children: [
          Text(
            '01 / 03',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'Next',
            icon: Icons.arrow_forward,

            onPressed: _nextPage,
          ),
        ],
      );
    } else if (_currentPage == 1) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: _currentPage == index ? 24 : 16,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _prevPage,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  text: 'Next Step',
                  icon: Icons.arrow_forward,

                  onPressed: _nextPage,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: _currentPage == index ? 24 : 16,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          PrimaryButton(text: 'Get Started', onPressed: _nextPage),
          const SizedBox(height: 16),
          Text('Step 3 of 3', style: AppTextStyles.bodyMedium),
        ],
      );
    }
  }
}
