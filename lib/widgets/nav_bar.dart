// custom_app_bar.dart
import 'package:flutter/material.dart';
import '../assets/theme.dart';

AppBar TopNavBar({required Color colorSecond}) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.menu, color: Colors.white),
      onPressed: () {},
    ),
    title: const Text(
      '365.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
    backgroundColor: AppColors.primary,
    centerTitle: true,
    actions: [
      IconButton(
        //icon: Icon(Icons.notifications_outlined, color: colorSecond),
        icon: const Icon(Icons.local_fire_department_outlined, color: AppColors.accent),
        onPressed: () {},
        padding: const EdgeInsets.only(right: 10),
      ),
    ],
  );
}
