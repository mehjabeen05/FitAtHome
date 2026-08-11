import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/rating_badge.dart';

class AdminProfessionalsScreen extends StatefulWidget {
  const AdminProfessionalsScreen({super.key});

  @override
  State<AdminProfessionalsScreen> createState() => _AdminProfessionalsScreenState();
}

class _AdminProfessionalsScreenState extends State<AdminProfessionalsScreen> {
  late Set<String> _verifiedIds = mockProfessionals.where((p) => p.isVerified).map((p) => p.id).toSet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        itemCount: mockProfessionals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final professional = mockProfessionals[i];
          final verified = _verifiedIds.contains(professional.id);
          return AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
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
                      Text(professional.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 3),
                      Text(professional.profession, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      const SizedBox(height: 4),
                      RatingBadge(rating: professional.rating, fontSize: 11),
                    ],
                  ),
                ),
                if (verified)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Verified', style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w700)),
                  )
                else
                  ElevatedButton(
                    onPressed: () => setState(() => _verifiedIds.add(professional.id)),
                    child: const Text('Verify'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
