import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../models/professional_model.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/rating_badge.dart';
import '../../../shared/widgets/primary_button.dart';
import '../booking/booking_screen.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  final Professional professional;

  const ProfessionalProfileScreen({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    final categoryNames = mockServiceCategories
        .where((c) => professional.serviceCategoryIds.contains(c.id))
        .map((c) => c.name)
        .toList();
    final reviews = mockReviews.take(3).toList();

    return Scaffold(
      appBar: AppBar(title: Text(professional.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.primaryTint,
                  child: Text(
                    professional.initials,
                    style: const TextStyle(color: AppColors.primary, fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(professional.name, style: Theme.of(context).textTheme.titleLarge),
                    if (professional.isVerified) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.verified, color: AppColors.primary, size: 18),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${professional.profession} · ${professional.qualification}',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RatingBadge(rating: professional.rating, fontSize: 13),
                    const SizedBox(width: 6),
                    Text(
                      '(${professional.reviewCount} reviews)',
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.work_outline, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      '${professional.experienceYears} yrs',
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('About', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            professional.bio,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 20),
          Text('Services', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categoryNames
                .map((name) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        name,
                        style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      const Icon(Icons.currency_rupee, color: AppColors.primary),
                      const SizedBox(height: 4),
                      Text('₹${professional.basePricePerMinute.toStringAsFixed(0)}/min',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      const Icon(Icons.location_on_outlined, color: AppColors.primary),
                      const SizedBox(height: 4),
                      Text('${professional.distanceKm} km away',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Available slots', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: professional.availableSlots
                .map((slot) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(slot, style: const TextStyle(fontSize: 12)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Text('Reviews', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          ...reviews.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(r.userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        RatingBadge(rating: r.rating, fontSize: 11),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(r.comment, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.4)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: PrimaryButton(
            label: 'Book Now',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => BookingScreen(professional: professional)),
            ),
          ),
        ),
      ),
    );
  }
}
