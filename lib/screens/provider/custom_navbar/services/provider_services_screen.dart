import 'package:bookease/screens/provider/custom_navbar/services/provider_add_service_screen.dart';
import 'package:bookease/screens/provider/custom_navbar/services/provider_edit_service_screen.dart';
import 'package:bookease/screens/provider/custom_navbar/services/widgets/delete_dialog_widget.dart';
import 'package:bookease/screens/provider/custom_navbar/services/widgets/no_service_widget.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/service_provider_controller.dart';
import 'widgets/service_card_widget.dart';
import 'widgets/stat_card_widget.dart';

class ProviderServicesScreen extends StatefulWidget {
  const ProviderServicesScreen({super.key});

  @override
  State<ProviderServicesScreen> createState() => _ProviderServicesScreenState();
}

class _ProviderServicesScreenState extends State<ProviderServicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceController>().getMyServices(
        onError: () {
          showCustomMsg(
            context,
            context.read<ServiceController>().error ??
                'Failed to load services',
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: Text(
          'My Services',
          style: AppTextStyles.h2.copyWith(
            fontSize: 20,
            color: AppColors.primary,
          ),
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
      body: Consumer<ServiceController>(
        builder: (context, service, child) {
          if (service.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatCardWidget(
                        label: 'Total Services',
                        value: service.services.length.toString(),
                        color: const Color(0xFFE8EAF6),
                        valueColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCardWidget(
                        label: 'Active Now',
                        value: service.services
                            .where((s) => s.isActive)
                            .length
                            .toString(),
                        color: const Color(0xFFFCE4EC),
                        valueColor: const Color(0xFFC2185B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                if (service.services.isEmpty) NoServiceWidget(),

                ...service.services.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ServiceCardWidget(
                      service: s,
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProviderEditServiceScreen(service: s),
                          ),
                        );
                      },
                      onDelete: () => deleteDialogWidget(context, s.id),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProviderAddServiceScreen(),
            ),
          ).then((_) {
            context.read<ServiceController>().getMyServices(onError: () {});
          });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
