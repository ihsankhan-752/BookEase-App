import 'package:flutter/material.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/widgets/customer/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 2; // Notifications tab is active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Notifications',
          style: AppTextStyles.h2.copyWith(fontSize: 20), // Black title according to design
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                  Text(
                    'Mark all as read',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Recent Notifications
              NotificationCard(
                isUnread: true,
                iconBackgroundColor: AppColors.primary.withOpacity(0.15),
                iconContent: const Icon(Icons.check_circle_outline, color: AppColors.primary),
                title: 'Booking Confirmed',
                time: '2m ago',
                message: 'Your cleaning service with Elite Shine is confirmed for tomorrow at 10:00 AM.',
              ),
              NotificationCard(
                isUnread: false,
                iconBackgroundColor: Colors.redAccent.withOpacity(0.15),
                iconContent: const Icon(Icons.payments_outlined, color: Colors.redAccent),
                title: 'Payment Successful',
                time: '1h ago',
                message: "We've received your payment of \$85.00 for request #SH-9821. Receipt sent to your email.",
              ),
              NotificationCard(
                isUnread: true,
                isMessageItalic: true,
                iconBackgroundColor: Colors.grey.shade200,
                iconContent: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: 'New Message from Sarah',
                time: '3h ago',
                message: '"Hi there! I\'m just confirming the gate code for tomorrow\'s visit..."',
                actions: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      minimumSize: const Size(0, 32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Reply', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      minimumSize: const Size(0, 32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('View Details', style: TextStyle(color: Colors.grey.shade800, fontSize: 12)),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Earlier Today Header
              Text(
                'EARLIER TODAY',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 16),

              // Earlier Notifications
              NotificationCard(
                isUnread: false,
                iconBackgroundColor: Colors.grey.shade200,
                iconContent: Icon(Icons.notifications_outlined, color: Colors.grey.shade700),
                title: 'Rate your experience',
                time: '8h ago',
                message: 'How was your plumbing service with Jack? Share your feedback to help others.',
              ),
              NotificationCard(
                isUnread: false,
                iconBackgroundColor: Colors.grey.shade200,
                iconContent: Icon(Icons.info_outline, color: Colors.grey.shade700),
                title: 'Service Update',
                time: '12h ago',
                message: 'New professional landscaping services are now available in your area! Explore the catalog.',
              ),

              const SizedBox(height: 24),

              // Stay Tuned Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_active_outlined, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Stay Tuned',
                      style: AppTextStyles.h2.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Turn on push notifications to never miss an update on your bookings or messages.',
                      style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Enable Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
