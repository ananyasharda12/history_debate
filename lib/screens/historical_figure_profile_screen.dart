import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/historical_figure.dart';
import 'debate_chat_screen.dart';

class HistoricalFigureProfileScreen extends StatelessWidget {
  final HistoricalFigure figure;

  const HistoricalFigureProfileScreen({
    super.key,
    required this.figure,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Historical Figure',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Portrait
            CircleAvatar(
              radius: 60,
              backgroundColor: AppTheme.darkMaroon,
              child: const Icon(
                Icons.person,
                size: 60,
                color: AppTheme.whiteText,
              ),
            ),
            const SizedBox(height: 16),
            
            // Name and Title
            Text(
              figure.name,
              style: const TextStyle(
                color: AppTheme.whiteText,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              figure.title,
              style: const TextStyle(
                color: AppTheme.whiteText,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              figure.lifespan,
              style: const TextStyle(
                color: AppTheme.whiteText,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            
            // Information Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildInfoCard('Core Beliefs', figure.coreBeliefs),
                  const SizedBox(height: 16),
                  _buildInfoCard('Speech Style', figure.speechStyle),
                  const SizedBox(height: 16),
                  _buildInfoCard('Key Decisions', figure.keyDecisions),
                  const SizedBox(height: 16),
                  _buildQuoteCard('Famous Quotes', figure.famousQuote),
                  const SizedBox(height: 32),
                  
                  // How He Would Argue Today
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'How He Would Argue Today',
                      style: TextStyle(
                        color: AppTheme.whiteText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Modern Views Cards
                  ...figure.modernViews.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildModernViewCard(entry.key, entry.value),
                    );
                  }),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Start Debate Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DebateChatScreen(figure: figure),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      // Bottom nav is handled by MainNavigationScreen (if used as a tab)
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(String title, String quote) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(left: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: AppTheme.brightRed, width: 4),
              ),
            ),
            child: Text(
              quote,
              style: const TextStyle(
                color: AppTheme.whiteText,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernViewCard(String topic, String view) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.darkCard,
            AppTheme.darkCard.withOpacity(0.7),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            topic,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            view,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

}

