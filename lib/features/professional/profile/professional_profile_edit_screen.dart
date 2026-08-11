import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../shared/widgets/primary_button.dart';

class ProfessionalProfileEditScreen extends StatefulWidget {
  const ProfessionalProfileEditScreen({super.key});

  @override
  State<ProfessionalProfileEditScreen> createState() => _ProfessionalProfileEditScreenState();
}

class _ProfessionalProfileEditScreenState extends State<ProfessionalProfileEditScreen> {
  final _nameController = TextEditingController(text: 'Riya Agarwal');
  final _qualificationController = TextEditingController(text: 'RYT-500 Certified');
  final _experienceController = TextEditingController(text: '6');
  final _priceController = TextEditingController(text: '8');

  final Set<String> _selectedCategoryIds = {'yoga', 'mobility'};
  final Set<String> _selectedSlots = {'7:00 AM', '8:30 AM', '10:00 AM'};

  static const List<String> _allSlots = [
    '6:00 AM', '6:30 AM', '7:00 AM', '7:30 AM', '8:00 AM', '8:30 AM',
    '10:00 AM', '5:30 PM', '6:00 PM', '7:00 PM', '8:00 PM',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _qualificationController.dispose();
    _experienceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        children: [
          Text('Edit Profile', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          const Text('Name', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          TextField(controller: _nameController),
          const SizedBox(height: 16),
          const Text('Qualification', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          TextField(controller: _qualificationController),
          const SizedBox(height: 16),
          const Text('Experience (years)', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          TextField(controller: _experienceController, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          const Text('Base price per minute (₹)', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          TextField(controller: _priceController, keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          Text('Services offered', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: mockServiceCategories.map((category) {
              final selected = _selectedCategoryIds.contains(category.id);
              return GestureDetector(
                onTap: () => setState(() {
                  if (selected) {
                    _selectedCategoryIds.remove(category.id);
                  } else {
                    _selectedCategoryIds.add(category.id);
                  }
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                  ),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text('Availability', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _allSlots.map((slot) {
              final selected = _selectedSlots.contains(slot);
              return GestureDetector(
                onTap: () => setState(() {
                  if (selected) {
                    _selectedSlots.remove(slot);
                  } else {
                    _selectedSlots.add(slot);
                  }
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primaryTint : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                  ),
                  child: Text(
                    slot,
                    style: TextStyle(
                      fontSize: 12,
                      color: selected ? AppColors.primary : AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Save Changes',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated (mock)')),
            ),
          ),
        ],
      ),
    );
  }
}
