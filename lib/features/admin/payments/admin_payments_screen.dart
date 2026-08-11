import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_card.dart';

class AdminPaymentsScreen extends StatelessWidget {
  const AdminPaymentsScreen({super.key});

  static const List<Map<String, String>> _payments = [
    {'bookingId': 'FAH-20260812-0001', 'amount': '₹289', 'date': '12 Aug 2026', 'status': 'Paid'},
    {'bookingId': 'FAH-20260812-0002', 'amount': '₹649', 'date': '12 Aug 2026', 'status': 'Paid'},
    {'bookingId': 'FAH-20260728-0014', 'amount': '₹469', 'date': '28 Jul 2026', 'status': 'Paid'},
    {'bookingId': 'FAH-20260710-0002', 'amount': '₹319', 'date': '10 Jul 2026', 'status': 'Refunded'},
    {'bookingId': 'FAH-20260705-0031', 'amount': '₹159', 'date': '05 Jul 2026', 'status': 'Refunded'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        itemCount: _payments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final payment = _payments[i];
          final paid = payment['status'] == 'Paid';
          final color = paid ? AppColors.success : AppColors.danger;
          return AppCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(payment['bookingId']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                      const SizedBox(height: 3),
                      Text(payment['date']!, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
                Text(payment['amount']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    payment['status']!,
                    style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
