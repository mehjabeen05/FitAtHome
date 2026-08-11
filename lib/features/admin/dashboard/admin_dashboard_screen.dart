import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../shared/widgets/app_card.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late Set<String> _verifiedIds = mockProfessionals.where((p) => p.isVerified).map((p) => p.id).toSet();

  @override
  Widget build(BuildContext context) {
    final pending = mockProfessionals.where((p) => !_verifiedIds.contains(p.id)).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: const [
              _StatCard(label: 'Total Users', value: '1,248'),
              _StatCard(label: 'Total Professionals', value: '86'),
              _StatCard(label: 'Active Bookings', value: '37'),
              _StatCard(label: 'Total Revenue', value: '₹6,42,500'),
            ],
          ),
          const SizedBox(height: 24),
          Text('Pending Verifications', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          if (pending.isEmpty)
            const Text('No pending verifications', style: TextStyle(color: AppColors.textMuted, fontSize: 13))
          else
            ...pending.map(
              (professional) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(professional.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            const SizedBox(height: 3),
                            Text(professional.profession, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => setState(() => _verifiedIds.add(professional.id)),
                        child: const Text('Verify'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}
