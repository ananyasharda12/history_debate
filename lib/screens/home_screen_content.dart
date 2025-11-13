import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/main_navigation_screen.dart';
import '../models/historical_figure.dart';
import 'type_topic_screen.dart';
import 'pick_figure_screen.dart';
import 'settings_screen.dart';
import 'debate_chat_screen.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  // Default figure for quick start debate
  static const _defaultFigure = HistoricalFigure(
    id: '1',
    name: 'Abraham Lincoln',
    title: '16th President of the United States',
    lifespan: '1809-1865',
    imageUrl: '',
    coreBeliefs: 'Lincoln believed in the preservation of the Union, the abolition of slavery, and the importance of democracy and equality for all citizens.',
    speechStyle: 'Lincoln was known for his eloquent and persuasive speeches, often using clear and concise language to convey complex ideas.',
    keyDecisions: "Lincoln's key decisions include issuing the Emancipation Proclamation, leading the Union through the Civil War, and delivering the Gettysburg Address.",
    famousQuote: 'Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.',
    modernViews: {
      'Climate Change': 'Lincoln would likely emphasize the moral imperative to protect future generations and the need for collective action.',
      'Healthcare': 'Lincoln would likely advocate for a system that ensures access to healthcare for all citizens, emphasizing social responsibility.',
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
                        // Navigate directly to chat screen with default figure
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DebateChatScreen(
                              figure: _defaultFigure,
                            ),
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
                            builder: (context) => const PickFigureScreen(),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TypeTopicScreen(),
                          ),
                        );
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

