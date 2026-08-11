import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_card.dart';

class AdminComplaintsScreen extends StatefulWidget {
  const AdminComplaintsScreen({super.key});

  @override
  State<AdminComplaintsScreen> createState() => _AdminComplaintsScreenState();
}

class _Complaint {
  final String userName;
  final String text;
  final String date;
  bool resolved;

  _Complaint({
    required this.userName,
    required this.text,
    required this.date,
    this.resolved = false,
  });
}

class _AdminComplaintsScreenState extends State<AdminComplaintsScreen> {
  final List<_Complaint> _complaints = [
    _Complaint(
      userName: 'Rahul Deshmukh',
      text: 'The trainer arrived 20 minutes late without any prior notice.',
      date: '08 Aug 2026',
    ),
    _Complaint(
      userName: 'Sneha Joshi',
      text: 'Session felt shorter than the booked duration.',
      date: '02 Aug 2026',
    ),
    _Complaint(
      userName: 'Manish Kumar',
      text: 'Would like a refund as the professional cancelled last minute.',
      date: '27 Jul 2026',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        itemCount: _complaints.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final complaint = _complaints[i];
          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(complaint.userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    Text(complaint.date, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(complaint.text, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.4)),
                const SizedBox(height: 10),
                if (complaint.resolved)
                  const Text('Resolved', style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.w700))
                else
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => setState(() => complaint.resolved = true),
                      child: const Text('Resolve'),
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
