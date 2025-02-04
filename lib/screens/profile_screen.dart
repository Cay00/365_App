import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../assets/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      // Użycie customAppBar
      body: Container(
        margin: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }
}
