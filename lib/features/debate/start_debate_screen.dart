import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/historical_figure.dart';
import '../../theme/app_theme.dart';
import '../figures/historical_figure_profile_screen.dart';
import '../figures/providers/figure_provider.dart';
import 'debate_chat_screen.dart';

class StartDebateScreen extends StatelessWidget {
  const StartDebateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final figureProvider = context.watch<FigureProvider>();
    final figures = figureProvider.figures;

    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      appBar: AppBar(
        backgroundColor: AppTheme.darkNavy,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Start a Debate',
          style: TextStyle(
            color: AppTheme.whiteText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Your Opponent',
                  style: TextStyle(
                    color: AppTheme.whiteText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Figure Cards
            Expanded(
              child: figureProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.brightRed,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: figures.length,
                      itemBuilder: (context, index) {
                        return _buildFigureCard(context, figures[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFigureCard(BuildContext context, HistoricalFigure figure) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          // Portrait
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppTheme.darkCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person,
              size: 100,
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            figure.title,
            style: const TextStyle(color: AppTheme.lightGray, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            figure.name,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            figure.lifespan,
            style: const TextStyle(color: AppTheme.lightGray, fontSize: 14),
          ),
          const SizedBox(height: 16),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HistoricalFigureProfileScreen(figure: figure),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.darkMaroon,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Preview',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateChatScreen(
                          figure: figure,
                          initialTopic: 'Open debate',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brightRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start Debate',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
