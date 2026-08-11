import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'bookings/my_bookings_screen.dart';
import 'profile/profile_screen.dart';

class UserRootShell extends StatefulWidget {
  final int initialIndex;

  const UserRootShell({super.key, this.initialIndex = 0});

  @override
  State<UserRootShell> createState() => _UserRootShellState();
}

class _UserRootShellState extends State<UserRootShell> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const MyBookingsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
