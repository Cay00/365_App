import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../assets/theme.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            'Statistics Screen',
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }
}
