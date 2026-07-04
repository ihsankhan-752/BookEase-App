import 'package:flutter/material.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/widgets/customer/booking_service_card.dart';
import 'package:bookease/routes/app_routes.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedIndex = 1; // Bookings tab is active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'BookEase',
          style: AppTextStyles.h2.copyWith(color: AppColors.primary, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for home services...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade500),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Row(
              children: [
                _buildFilterChip(label: 'Price', isActive: true, icon: Icons.tune),
                const SizedBox(width: 12),
                _buildFilterChip(label: 'Rating', isActive: false),
                const SizedBox(width: 12),
                _buildFilterChip(label: 'Availability', isActive: false),
                const SizedBox(width: 12),
                _buildFilterChip(label: 'Top', isActive: false),
              ],
            ),
          ),
          
          const SizedBox(height: 8),

          // Services List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: [
                BookingServiceCard(
                  title: 'Deep House Cleaning',
                  description: 'Professional whole-home sanitation and deep scrubbing for a pristine finish.',
                  providerName: 'CleanPro Solutions',
                  rating: 4.8,
                  price: '\$45',
                  priceUnit: '/hr',
                  imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800&q=80',
                  providerImageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetail),
                ),
                BookingServiceCard(
                  title: 'AC Maintenance & Repair',
                  description: 'Keep your home cool with expert maintenance and quick part replacements.',
                  providerName: 'CoolAir Experts',
                  rating: 4.9,
                  price: '\$60',
                  priceUnit: '/fix',
                  imageUrl: 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=800&q=80',
                  providerImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetail),
                ),
                BookingServiceCard(
                  title: 'Garden Landscaping',
                  description: 'Complete outdoor care including mowing, trimming, and seasonal planting.',
                  providerName: 'GreenThumb Co.',
                  rating: 4.7,
                  price: '\$35',
                  priceUnit: '/hr',
                  imageUrl: 'https://images.unsplash.com/photo-1585320806297-9794b3e4ce88?w=800&q=80',
                  providerImageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetail),
                ),
                BookingServiceCard(
                  title: 'Emergency Plumbing',
                  description: 'Rapid response for leaks, blockages, and pipe repairs available 24/7.',
                  providerName: 'FlowRight Hub',
                  rating: 4.5,
                  price: '\$80',
                  priceUnit: '/call',
                  imageUrl: 'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?w=800&q=80',
                  providerImageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&q=80',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetail),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({required String label, required bool isActive, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: isActive ? Colors.white : Colors.grey.shade700),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
