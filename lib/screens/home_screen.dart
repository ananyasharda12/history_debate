import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'historical_figures_screen.dart';
import 'library_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Debate AI',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: AppTheme.whiteText),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: AppTheme.brightRed,
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            const SizedBox(height: 40),

            // Main Title
            const Text(
              'Debate with Historical Figures',
              style: TextStyle(
                color: AppTheme.whiteText,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'serif',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Action Buttons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildActionButton(
                      context,
                      'Start a Debate',
                      AppTheme.brightRed,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HistoricalFiguresScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context,
                      'Pick a Historical Figure',
                      AppTheme.brightRed,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HistoricalFiguresScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context,
                      'Type a Topic',
                      AppTheme.brightRed,
                      () {
                        // Navigate to topic input
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context,
                      'Replay Past Debates',
                      AppTheme.darkMaroon,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LibraryScreen(),
                          ),
                        );
                      },
                      textColor: AppTheme.lightRed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context, 0),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    Color backgroundColor,
    VoidCallback onPressed, {
    Color? textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppTheme.whiteText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, int currentIndex) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(color: AppTheme.darkNavy),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home, 'Home', 0, currentIndex),
          _buildNavItem(context, Icons.campaign, 'Debate', 1, currentIndex),
          _buildNavItem(
            context,
            Icons.library_books,
            'Library',
            2,
            currentIndex,
          ),
          _buildNavItem(context, Icons.people, 'Figures', 3, currentIndex),
          _buildNavItem(context, Icons.person, 'Profile', 4, currentIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    int currentIndex,
  ) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LibraryScreen()),
          );
        }
      },
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
