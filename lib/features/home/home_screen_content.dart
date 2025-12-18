import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../navigation/main_navigation_screen.dart';
import '../../models/historical_figure.dart';
import '../../screens/type_topic_screen.dart';
import '../figures/pick_figure_screen.dart';
import '../profile/settings_screen.dart';
import '../debate/debate_chat_screen.dart';
import '../debate/start_debate_flow_screen.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  // Default figure for quick start debate (kept for future use)
  static const _defaultFigure = HistoricalFigure(
    id: '1',
    name: 'Abraham Lincoln',
    title: '16th President of the United States',
    lifespan: '1809-1865',
    imageUrl: '',
    coreBeliefs:
        'Lincoln believed in the preservation of the Union, the abolition of slavery, and the importance of democracy and equality for all citizens.',
    speechStyle:
        'Lincoln was known for his eloquent and persuasive speeches, often using clear and concise language to convey complex ideas.',
    keyDecisions:
        "Lincoln's key decisions include issuing the Emancipation Proclamation, leading the Union through the Civil War, and delivering the Gettysburg Address.",
    famousQuote:
        'Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.',
    modernViews: {
      'Climate Change':
          'Lincoln would likely emphasize the moral imperative to protect future generations and the need for collective action.',
      'Healthcare':
          'Lincoln would likely advocate for a system that ensures access to healthcare for all citizens, emphasizing social responsibility.',
    },
  );

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
