import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_card.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  static const List<Map<String, String>> _users = [
    {'name': 'Aisha Verma', 'phone': '+91 98765 43210', 'joined': '12 Jan 2026'},
    {'name': 'Rahul Deshmukh', 'phone': '+91 91234 56789', 'joined': '03 Feb 2026'},
    {'name': 'Sneha Joshi', 'phone': '+91 99887 66554', 'joined': '18 Mar 2026'},
    {'name': 'Manish Kumar', 'phone': '+91 90011 22334', 'joined': '25 Apr 2026'},
    {'name': 'Pooja Nair', 'phone': '+91 98123 45670', 'joined': '09 Jun 2026'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        itemCount: _users.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final user = _users[i];
          return AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primaryTint,
                  child: Text(
                    user['name']!.substring(0, 1),
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 3),
                      Text(user['phone']!, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
                Text('Joined ${user['joined']}', style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          );
        },
      ),
    );
  }
}
