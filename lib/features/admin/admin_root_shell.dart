import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'dashboard/admin_dashboard_screen.dart';
import 'users/admin_users_screen.dart';
import 'professionals/admin_professionals_screen.dart';
import 'bookings/admin_bookings_screen.dart';
import 'services/admin_services_screen.dart';
import 'payments/admin_payments_screen.dart';
import 'complaints/admin_complaints_screen.dart';

class AdminRootShell extends StatefulWidget {
  const AdminRootShell({super.key});

  @override
  State<AdminRootShell> createState() => _AdminRootShellState();
}

class _AdminSection {
  final String label;
  final IconData icon;
  final Widget screen;

  const _AdminSection(this.label, this.icon, this.screen);
}

class _AdminRootShellState extends State<AdminRootShell> {
  int _index = 0;

  static const List<_AdminSection> _sections = [
    _AdminSection('Dashboard', Icons.dashboard_outlined, AdminDashboardScreen()),
    _AdminSection('Users', Icons.people_outline, AdminUsersScreen()),
    _AdminSection('Professionals', Icons.badge_outlined, AdminProfessionalsScreen()),
    _AdminSection('Bookings', Icons.event_note_outlined, AdminBookingsScreen()),
    _AdminSection('Services', Icons.category_outlined, AdminServicesScreen()),
    _AdminSection('Payments', Icons.payments_outlined, AdminPaymentsScreen()),
    _AdminSection('Complaints', Icons.report_gmailerrorred_outlined, AdminComplaintsScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: AppColors.primary,
                child: const Text(
                  'Admin Panel',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),
              ..._sections.asMap().entries.map((entry) {
                final selected = entry.key == _index;
                final section = entry.value;
                return ListTile(
                  leading: Icon(section.icon, color: selected ? AppColors.primary : AppColors.textMuted),
                  title: Text(
                    section.label,
                    style: TextStyle(
                      color: selected ? AppColors.primary : AppColors.textPrimary,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  selected: selected,
                  onTap: () {
                    setState(() => _index = entry.key);
                    Navigator.of(context).pop();
                  },
                );
              }),
            ],
          ),
        ),
      ),
      body: _sections[_index].screen,
    );
  }
}
