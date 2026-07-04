import 'dart:io';

import 'package:bookease/models/service_model.dart';
import 'package:bookease/screens/service_provider/custom_navbar/services/widgets/add_service_category_dropdown.dart';
import 'package:bookease/screens/service_provider/custom_navbar/services/widgets/add_service_duration_dropdown_widget.dart';
import 'package:bookease/screens/service_provider/custom_navbar/services/widgets/add_service_text_field.dart';
import 'package:bookease/screens/service_provider/custom_navbar/services/widgets/edit_service_image_upload_widget.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:bookease/utils/show_custom_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/service_provider_controller.dart';

class ProviderEditServiceScreen extends StatefulWidget {
  final ServiceModel service;

  const ProviderEditServiceScreen({super.key, required this.service});

  @override
  State<ProviderEditServiceScreen> createState() =>
      _ProviderEditServiceScreenState();
}

class _ProviderEditServiceScreenState extends State<ProviderEditServiceScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late String _selectedDuration;
  late String _selectedCategory;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.service.name);
    _descriptionController = TextEditingController(
      text: widget.service.description,
    );
    _priceController = TextEditingController(
      text: widget.service.price.toString(),
    );
    _selectedDuration = _durationToString(widget.service.duration);
    _selectedCategory = widget.service.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  String _durationToString(int minutes) {
    switch (minutes) {
      case 30:
        return '30 mins';
      case 60:
        return '1 hour';
      case 120:
        return '2 hours';
      case 180:
        return '3 hours';
      default:
        return '1 hour';
    }
  }

  int _parseDuration(String duration) {
    switch (duration) {
      case '30 mins':
        return 30;
      case '1 hour':
        return 60;
      case '2 hours':
        return 120;
      case '3 hours':
        return 180;
      default:
        return 60;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Service',
          style: AppTextStyles.h2.copyWith(fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Center(
              child: Text(
                'BookEase',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UpdateServiceImageUploadWidget(
                      selectedImage: _selectedImage,
                      existingImageUrl: widget.service.image.url,
                      onImagePicked: (file) =>
                          setState(() => _selectedImage = file),
                    ),
                    const SizedBox(height: 24),
                    AddServiceTextField(
                      label: 'Service Name',
                      hintText: 'e.g., Deep Kitchen Cleaning',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 24),
                    AddServiceTextField(
                      label: 'Description',
                      hintText: 'Describe your service...',
                      controller: _descriptionController,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    AddServiceTextField(
                      label: 'Price (\$)',
                      hintText: '0.00',
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      prefixText: '\$',
                    ),
                    const SizedBox(height: 24),
                    AddServiceDurationDropdownWidget(
                      selectedDuration: _selectedDuration,
                      onChanged: (val) =>
                          setState(() => _selectedDuration = val),
                    ),
                    const SizedBox(height: 24),
                    AddServiceCategoryDropdown(
                      selectedCategory: _selectedCategory,
                      onChanged: (val) =>
                          setState(() => _selectedCategory = val),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Consumer<ServiceController>(
                builder: (context, service, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: service.isLoading
                          ? null
                          : () {
                              service.updateService(
                                serviceId: widget.service.id,
                                name: _nameController.text.trim(),
                                description: _descriptionController.text.trim(),
                                duration: _parseDuration(_selectedDuration),
                                price:
                                    double.tryParse(
                                      _priceController.text.trim(),
                                    ) ??
                                    0,
                                category: _selectedCategory,
                                image: _selectedImage,
                                onSuccess: () {
                                  showCustomMsg(
                                    context,
                                    'Service Updated Successfully',
                                  );
                                  Navigator.pop(context);
                                },
                                onError: () {
                                  showCustomMsg(
                                    context,
                                    service.error ?? 'Failed to update service',
                                  );
                                },
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: service.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update Service',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
