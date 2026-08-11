import 'package:flutter/material.dart';
import 'dashboard/professional_dashboard_screen.dart';
import 'bookings/professional_bookings_screen.dart';
import 'earnings/professional_earnings_screen.dart';
import 'profile/professional_profile_edit_screen.dart';

class ProfessionalRootShell extends StatefulWidget {
  const ProfessionalRootShell({super.key});

  @override
  State<ProfessionalRootShell> createState() => _ProfessionalRootShellState();
}

class _ProfessionalRootShellState extends State<ProfessionalRootShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = const [
      ProfessionalDashboardScreen(),
      ProfessionalBookingsScreen(),
      ProfessionalEarningsScreen(),
      ProfessionalProfileEditScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Earnings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
