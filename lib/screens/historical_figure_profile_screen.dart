import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/historical_figure.dart';
import 'debate_chat_screen.dart';

class HistoricalFigureProfileScreen extends StatelessWidget {
  final HistoricalFigure figure;

  const HistoricalFigureProfileScreen({super.key, required this.figure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          figure.name,
          style: const TextStyle(
            color: AppTheme.whiteText,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
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
              figure.title,
              style: const TextStyle(
                color: AppTheme.whiteText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              figure.lifespan,
              style: const TextStyle(color: AppTheme.lightRed, fontSize: 13),
            ),
            const SizedBox(height: 28),

            // Info Cards
            _buildInfoCard('💭 Beliefs & Ideals', figure.coreBeliefs),
            const SizedBox(height: 16),
            _buildInfoCard('🗣️ Speech Style', figure.speechStyle),
            const SizedBox(height: 16),
            _buildInfoCard('⚖️ Key Actions', figure.keyDecisions),
            const SizedBox(height: 16),
            _buildQuoteCard('✍️ Notable Quote', figure.famousQuote),
            const SizedBox(height: 28),

            // Modern Views
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '🌍 How They Might Argue Today',
                style: TextStyle(
                  color: AppTheme.whiteText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...figure.modernViews.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildModernViewCard(entry.key, entry.value),
              );
            }),

            const SizedBox(height: 32),

            // Start Debate Button
            SizedBox(
              width: double.infinity,
              height: 52,
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
                  'Debate This Figure',
                  style: TextStyle(
                    color: AppTheme.whiteText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
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
              height: 1.4,
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
            padding: const EdgeInsets.only(left: 14),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: AppTheme.brightRed, width: 3),
              ),
            ),
            child: Text(
              '"$quote"',
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
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topic,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            view,
            style: const TextStyle(color: AppTheme.whiteText, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
