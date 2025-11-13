import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(color: AppTheme.darkNavy),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0, currentIndex, onTap),
          _buildNavItem(Icons.campaign, 'Debate', 1, currentIndex, onTap),
          _buildNavItem(Icons.library_books, 'Library', 2, currentIndex, onTap),
          _buildNavItem(Icons.people, 'Figures', 3, currentIndex, onTap),
          _buildNavItem(Icons.person, 'Profile', 4, currentIndex, onTap),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    int currentIndex,
    Function(int) onTap,
  ) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppTheme.brightRed : AppTheme.whiteText,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppTheme.brightRed : AppTheme.whiteText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}


