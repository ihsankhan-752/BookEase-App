import 'package:bookease/screens/provider/custom_navbar/services/provider_services_tab.dart';
import 'package:bookease/screens/provider/custom_navbar/settings/provider_settings_tab.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'bookings/provider_bookings_tab.dart';
import 'dashboard/provider_home_tab.dart';
import 'earnings/provider_earnings_tab.dart';

class ProviderDashboardScreen extends StatefulWidget {
  const ProviderDashboardScreen({super.key});

  @override
  State<ProviderDashboardScreen> createState() =>
      _ProviderDashboardScreenState();
}

class _ProviderDashboardScreenState extends State<ProviderDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ProviderHomeScreen(),
    const ProviderServicesScreen(),
    const ProviderBookingsScreen(),
    const ProviderEarningsScreen(),
    const ProviderSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: _screens),
      ),
      floatingActionButton:
          _selectedIndex == 0 || _selectedIndex == 1 || _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/provider_add_service');
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primary.withOpacity(0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard, color: AppColors.primary),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build, color: AppColors.primary),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today, color: AppColors.primary),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(
              Icons.account_balance_wallet,
              color: AppColors.primary,
            ),
            label: 'Earnings',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: AppColors.primary),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
