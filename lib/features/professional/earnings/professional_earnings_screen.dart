import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../models/booking_model.dart';
import '../../../shared/widgets/app_card.dart';

class ProfessionalEarningsScreen extends StatelessWidget {
  const ProfessionalEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completed = mockBookings.where((b) => b.status == BookingStatus.completed).toList();
    final total = completed.fold<double>(0, (sum, b) => sum + b.sessionPrice);
    final maxAmount = completed.isEmpty
        ? 1.0
        : completed.map((b) => b.sessionPrice).reduce((a, b) => a > b ? a : b);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        children: [
          Text('Earnings', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Earnings', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 6),
                Text(
                  '₹${total.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Recent Sessions', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...completed.map(
            (booking) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(booking.serviceCategoryName,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                          const SizedBox(height: 3),
                          Text(
                            '${booking.date.day}/${booking.date.month}/${booking.date.year}',
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: SizedBox(
                              height: 6,
                              width: 120,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Stack(
                                    children: [
                                      Container(color: AppColors.primaryTint),
                                      Container(
                                        width: constraints.maxWidth * (booking.sessionPrice / maxAmount),
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${booking.sessionPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
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
