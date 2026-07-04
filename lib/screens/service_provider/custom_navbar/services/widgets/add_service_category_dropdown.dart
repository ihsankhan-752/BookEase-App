import 'package:bookease/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AddServiceCategoryDropdown extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const AddServiceCategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  static const List<String> categories = [
    'Cleaning',
    'Tutoring',
    'Plumbing',
    'Beauty',
    'Fitness',
    'Electrical',
    'Carpentry',
    'Painting',
    'Gardening',
    'Laundry',
    'Cooking',
    'Babysitting',
    'Pet Care',
    'Photography',
    'Interior Design',
    'Moving & Packing',
    'Car Wash',
    'IT Support',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: categories
                  .map(
                    (val) => DropdownMenuItem(
                      value: val,
                      child: Text(val, style: AppTextStyles.bodyMedium),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
