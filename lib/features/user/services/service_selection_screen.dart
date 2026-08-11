import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../models/service_model.dart';
import '../../../models/professional_model.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/rating_badge.dart';
import '../professional/professional_profile_screen.dart';

class ServiceSelectionScreen extends StatelessWidget {
  final ServiceCategory category;

  const ServiceSelectionScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var professionals = mockProfessionals
        .where((p) => p.serviceCategoryIds.contains(category.id))
        .toList();
    if (professionals.isEmpty) professionals = mockProfessionals;

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Text(
            category.description,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 20),
          ...professionals.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ProfessionalCard(professional: p),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfessionalCard extends StatelessWidget {
  final Professional professional;

  const _ProfessionalCard({required this.professional});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProfessionalProfileScreen(professional: professional)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryTint,
                child: Text(
                  professional.initials,
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(professional.name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      '${professional.profession} · ${professional.experienceYears} yrs exp',
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RatingBadge(rating: professional.rating, fontSize: 12),
                        const SizedBox(width: 10),
                        Text(
                          '${professional.distanceKm} km',
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '₹${professional.basePricePerMinute.toStringAsFixed(0)}/min',
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: professional.availableSlots.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    professional.availableSlots[i],
                    style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
