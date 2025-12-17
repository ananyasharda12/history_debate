import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../navigation/main_navigation_screen.dart';
import '../profile/settings_screen.dart';
import '../debate/start_debate_flow_screen.dart';
import '../figures/pick_figure_screen.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

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
            const SizedBox(height: 32),

            // Main Title + Tagline
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'Debate the Minds of History',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Challenge history's greatest thinkers on modern or classic issues in real-time debates.",
                    style: TextStyle(color: AppTheme.lightRed, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
                            builder: (context) => const StartDebateFlowScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildActionButton(
                      context,
                      'Replay Past Debates',
                      AppTheme.darkMaroon,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MainNavigationScreen(initialIndex: 2),
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
}
