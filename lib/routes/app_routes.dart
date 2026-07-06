import 'package:bookease/screens/auth/login_screen.dart';
import 'package:bookease/screens/auth/register_screen.dart';
import 'package:bookease/screens/shared/onboarding_screen.dart';
import 'package:bookease/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../models/booking_model.dart';
import '../models/service_model.dart';
import '../screens/customer/_/booking/booking_detail_screen.dart';
import '../screens/customer/_/booking/booking_form_screen.dart';
import '../screens/customer/_/booking/booking_screen.dart';
import '../screens/customer/_/custom_navbar.dart';
import '../screens/customer/_/home/service_detail_screen.dart';
import '../screens/customer/_/notification/notification_screen.dart';
import '../screens/customer/_/profile/profile_screen.dart';
import '../screens/service_provider/custom_navbar/bookings/provider_booking_details_screen.dart';
import '../screens/service_provider/custom_navbar/provider_custom_navbar.dart';
import '../screens/service_provider/custom_navbar/services/provider_add_service_screen.dart';
import '../screens/service_provider/provider_availability_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String onboarding = '/onboarding';
  static const String bookings = '/bookings';
  static const String bookingForm = '/booking_form';
  static const String bookingDetail = '/booking_detail';
  static const String serviceDetail = '/service_detail';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String providerDashboard = '/provider_dashboard';
  static const String providerAvailability = '/provider_availability';
  static const String providerBookingDetails = '/provider_booking_details';
  static const String providerAddService = '/provider_add_service';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const CustomNavbarScreen());
      case bookings:
        return MaterialPageRoute(builder: (_) => const BookingScreen());
      case bookingForm:
        final service = settings.arguments as ServiceModel;
        return MaterialPageRoute(
          builder: (_) => BookingFormScreen(service: service),
        );
      case bookingDetail:
        return MaterialPageRoute(builder: (_) => const BookingDetailScreen());
      case serviceDetail:
        final service = settings.arguments as ServiceModel;
        return MaterialPageRoute(
          builder: (_) => ServiceDetailScreen(service: service),
        );
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case providerDashboard:
        return MaterialPageRoute(
          builder: (_) => const ProviderDashboardScreen(),
        );
      case providerAvailability:
        return MaterialPageRoute(
          builder: (_) => const ProviderAvailabilityScreen(),
        );
      // in providerBookingCardWidget onTap

      case '/provider_booking_details':
        final booking = settings.arguments as BookingModel;
        return MaterialPageRoute(
          builder: (_) => ProviderBookingDetailsScreen(booking: booking),
        );
      case providerAddService:
        return MaterialPageRoute(
          builder: (_) => const ProviderAddServiceScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Route not found!')),
          ),
        );
    }
  }
}
