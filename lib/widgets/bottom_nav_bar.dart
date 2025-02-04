import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  const BottomNavBar(this.onItemTapped, this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF1E1E1E), width: 1)),
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined, color: Color(0xFF686868)),
            activeIcon: Icon(Icons.task_alt_outlined, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt_rounded, color: Color(0xFF686868)),
            activeIcon: Icon(Icons.signal_cellular_alt_rounded, color: Colors.white),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_rounded, color: Color(0xFF686868)),
            activeIcon: Icon(Icons.edit_note_rounded, color: Colors.white),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse_outlined, color: Color(0xFF686868)),
            activeIcon: Icon(Icons.timelapse_outlined, color: Colors.white),
            label: 'Pomodoro',
          ),
        ],
        currentIndex: selectedIndex,
        backgroundColor: const Color(0xFF0D0D0D),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF686868),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: onItemTapped,
      ),
    );
  }
}
