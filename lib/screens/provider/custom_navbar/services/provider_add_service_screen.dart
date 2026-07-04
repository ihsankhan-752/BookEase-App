import 'package:bookease/controllers/image_controller.dart';
import 'package:bookease/screens/provider/custom_navbar/services/widgets/add_service_appbar_widget.dart';
import 'package:bookease/screens/provider/custom_navbar/services/widgets/add_service_duration_dropdown_widget.dart';
import 'package:bookease/screens/provider/custom_navbar/services/widgets/add_service_image_upload_widget.dart';
import 'package:bookease/screens/provider/custom_navbar/services/widgets/add_service_text_field.dart';
import 'package:bookease/widgets/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/service_provider_controller.dart';
import '../../../../utils/show_custom_msg.dart';

class ProviderAddServiceScreen extends StatefulWidget {
  const ProviderAddServiceScreen({super.key});

  @override
  State<ProviderAddServiceScreen> createState() =>
      _ProviderAddServiceScreenState();
}

class _ProviderAddServiceScreenState extends State<ProviderAddServiceScreen> {
  String _selectedDuration = '1 hour';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const AddServiceAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AddServiceImageUploadWidget(),
                    const SizedBox(height: 24),
                    AddServiceTextField(
                      label: 'Service Name',
                      hintText: 'e.g., Deep Kitchen Cleaning',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 24),
                    AddServiceTextField(
                      label: 'Description',
                      hintText:
                          'Describe the inclusions and details of your service...',
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Consumer<ServiceController>(
                builder: (context, service, child) {
                  return PrimaryButton(
                    text: "Save Service",
                    isLoading: service.isLoading,
                    onPressed: service.isLoading
                        ? null
                        : () {
                            service.createService(
                              name: _nameController.text.trim(),
                              description: _descriptionController.text.trim(),
                              duration: _parseDuration(_selectedDuration),
                              price:
                                  double.tryParse(
                                    _priceController.text.trim(),
                                  ) ??
                                  0,
                              image: imageController.selectedImage!,
                              onSuccess: () {
                                showCustomMsg(
                                  context,
                                  'Service Created Successfully',
                                );
                                Navigator.pop(context);
                              },
                              onError: () {
                                showCustomMsg(
                                  context,
                                  service.error ?? 'Failed to create service',
                                );
                              },
                            );
                          },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
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
}
