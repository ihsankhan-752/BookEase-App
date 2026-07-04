import 'package:bookease/controllers/image_controller.dart';
import 'package:bookease/theme/app_colors.dart';
import 'package:bookease/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddServiceImageUploadWidget extends StatelessWidget {
  const AddServiceImageUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    if (imageController.selectedImage != null) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 2),
          image: DecorationImage(
            image: FileImage(imageController.selectedImage!),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: GestureDetector(
              onTap: () => imageController.removeImage(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(Icons.close_outlined, color: Colors.red),
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => imageController.pickImage(ImageSource.gallery),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Upload Service Image',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'JPEG, PNG up to 5MB',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
