import 'package:bookease/controllers/user_controller.dart';
import 'package:bookease/widgets/shared/text_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/show_custom_msg.dart';
import '../../../../widgets/customer/category_item.dart';
import '../../../../widgets/customer/provider_avatar.dart';
import '../../../../widgets/customer/service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserController>().getAllServices(
        onError: () {
          showCustomMsg(
            context,
            context.read<UserController>().error ?? 'Failed to load services',
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                SearchTextInput(),
                const SizedBox(width: 12),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.tune,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryItem(
                  title: 'Cleaning',
                  icon: Icons.cleaning_services_outlined,
                  isSelected: true,
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                CategoryItem(
                  title: 'Tutoring',
                  icon: Icons.school_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                CategoryItem(
                  title: 'Plumbing',
                  icon: Icons.plumbing_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                CategoryItem(
                  title: 'Beauty',
                  icon: Icons.face_retouching_natural_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                CategoryItem(
                  title: 'Fitness',
                  icon: Icons.fitness_center_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Services',
                  style: AppTextStyles.h2.copyWith(fontSize: 20),
                ),
                Text(
                  'See all',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Consumer<UserController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.services.isEmpty) {
                return const Center(child: Text("No Service Found Yet"));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.services.length,
                  itemBuilder: (context, index) {
                    final service = controller.services[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ServiceCard(
                        title: service.name,
                        company: service.serviceProviderName,
                        rating: service.averageRating,
                        reviewCount: service.totalReviews,
                        price: '\$${service.price.toStringAsFixed(0)}',
                        priceUnit: '/ session',
                        imageUrl: service.image.url ?? '',
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.serviceDetail,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Top Rated Providers',
              style: AppTextStyles.h2.copyWith(fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: const [
                ProviderAvatar(
                  name: 'Sarah J.',
                  imageUrl:
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
                ),
                ProviderAvatar(
                  name: 'Marcus W.',
                  imageUrl:
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80',
                ),
                ProviderAvatar(
                  name: 'Elena G.',
                  imageUrl:
                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
                ),
                ProviderAvatar(
                  name: 'David L.',
                  imageUrl:
                      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&q=80',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
