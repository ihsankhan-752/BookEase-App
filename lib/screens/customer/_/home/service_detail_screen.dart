import 'package:flutter/material.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/routes/app_routes.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Image.network(
              'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800&q=80',
              fit: BoxFit.cover,
            ),
          ),
          
          // App Bar with icons
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(Icons.arrow_back, () => Navigator.pop(context)),
                Row(
                  children: [
                    _buildIconButton(Icons.share_outlined, () {}),
                    const SizedBox(width: 12),
                    _buildIconButton(Icons.favorite_border, () {}),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable Content
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(24.0).copyWith(bottom: 100),
                children: [
                  Row(
                    children: [
                      const Icon(Icons.stars, color: AppColors.primary, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'PREMIUM SERVICE',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Deep House Cleaning',
                    style: AppTextStyles.h2.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star_border_rounded, color: Colors.redAccent, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '4.9 (124 reviews)',
                        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('•', style: TextStyle(color: Colors.grey)),
                      ),
                      const Icon(Icons.access_time, color: Colors.black87, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '3-5 hours',
                        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Provider Info
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sarah Johnson',
                              style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Top Rated Pro • 5 years exp.',
                              style: AppTextStyles.bodyMedium.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          minimumSize: Size.zero,
                        ),
                        child: const Text(
                          'Message',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Divider(color: Color(0xFFEEEEEE)),
                  ),
                  
                  // About the service
                  Text(
                    'About the service',
                    style: AppTextStyles.h2.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Complete top-to-bottom scrub of your entire home. Our deep cleaning goes beyond the surface to eliminate hidden dust, grime, and allergens. Perfect for seasonal resets or move-in/move-out needs.',
                    style: AppTextStyles.bodyMedium.copyWith(height: 1.5, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  
                  _buildCheckItem('Inside cabinets & appliances'),
                  _buildCheckItem('Baseboards & windowsills'),
                  _buildCheckItem('Sanitizing high-touch areas'),
                  _buildCheckItem('Eco-friendly supplies included'),
                  
                  const SizedBox(height: 24),
                  
                  // Reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews',
                        style: AppTextStyles.h2.copyWith(fontSize: 18),
                      ),
                      Text(
                        'View all',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildReviewCard('Michael R.', 'Sarah was incredible! My kitchen hasn\'t looked this clean since the day I moved in. Very meticulous and professional.', 5, 'M'),
                  const SizedBox(height: 12),
                  _buildReviewCard('Emily D.', 'Great service and arrived exactly on time. She really paid attention to the details I requested for the master bathroom.', 4, 'E', isLast: true),
                ],
              ),
            ),
          ),
          
          // Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('TOTAL PRICE', style: AppTextStyles.bodyMedium.copyWith(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('\$45', style: AppTextStyles.h2.copyWith(fontSize: 24)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0, left: 2.0),
                              child: Text(' /hr', style: AppTextStyles.bodyMedium),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.bookingForm);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Book Now', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87, size: 20),
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(text, style: AppTextStyles.bodyMedium.copyWith(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String name, String review, int stars, String initial, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isLast ? Colors.red.shade100 : Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: TextStyle(
                    color: isLast ? Colors.red.shade900 : Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star_border_rounded, 
                    color: index < stars ? Colors.redAccent : Colors.grey.shade300,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '"$review"',
            style: AppTextStyles.bodyMedium.copyWith(fontStyle: FontStyle.italic, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
