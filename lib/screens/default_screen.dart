import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../assets/theme.dart';
import 'todo_screen.dart';
import 'stats_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final Color _colorSecond = AppColors.secondary;

  final List<Widget> _screens = [
    const TodoScreen(),
    const StatsScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: TopNavBar(colorSecond: _colorSecond),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        key: ValueKey<int>(_selectedIndex),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavBar(_onItemTapped, _selectedIndex),
    );
  }
}
