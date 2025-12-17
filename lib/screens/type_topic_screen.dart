import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/debate/debate_chat_screen.dart';
import '../features/figures/providers/figure_provider.dart';
import '../models/historical_figure.dart';
import '../theme/app_theme.dart';

class TypeTopicScreen extends StatefulWidget {
  const TypeTopicScreen({super.key});

  @override
  State<TypeTopicScreen> createState() => _TypeTopicScreenState();
}

class _TypeTopicScreenState extends State<TypeTopicScreen> {
  final TextEditingController _topicController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _topicController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startDebate() {
    if (_topicController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a topic'),
          backgroundColor: AppTheme.brightRed,
        ),
      );
      return;
    }

    // Navigate to historical figures screen with the topic
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoricalFiguresScreenWithTopic(
          topic: _topicController.text.trim(),
        ),
      ),
    );
  }

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
          'Type a Topic',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Title
              const Text(
                'What would you like to debate about?',
                style: TextStyle(
                  color: AppTheme.whiteText,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                'Enter a topic and choose a historical figure to debate with',
                style: TextStyle(color: AppTheme.lightGray, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Topic Input
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.darkCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.brightRed.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _topicController,
                  focusNode: _focusNode,
                  style: const TextStyle(
                    color: AppTheme.whiteText,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g., Climate change, Healthcare, Education...',
                    hintStyle: TextStyle(
                      color: AppTheme.mediumGray,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  maxLines: 4,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _startDebate(),
                ),
              ),
              const SizedBox(height: 24),
              // Suggestions
              const Text(
                'Popular Topics:',
                style: TextStyle(
                  color: AppTheme.whiteText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTopicChip('Climate Change'),
                  _buildTopicChip('Healthcare'),
                  _buildTopicChip('Education'),
                  _buildTopicChip('Technology'),
                  _buildTopicChip('Democracy'),
                  _buildTopicChip('Economics'),
                ],
              ),
              const Spacer(),
              // Start Debate Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _startDebate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brightRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Choose a Historical Figure',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicChip(String topic) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _topicController.text = topic;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.darkMaroon,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.brightRed.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Text(
          topic,
          style: const TextStyle(color: AppTheme.whiteText, fontSize: 14),
        ),
      ),
    );
  }
}

// Extended HistoricalFiguresScreen that accepts a topic
class HistoricalFiguresScreenWithTopic extends StatelessWidget {
  final String topic;

  const HistoricalFiguresScreenWithTopic({super.key, required this.topic});

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Opponent',
              style: TextStyle(
                color: AppTheme.whiteText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Topic: $topic',
              style: const TextStyle(color: AppTheme.lightGray, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Topic Display
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.darkCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.brightRed.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.topic, color: AppTheme.brightRed, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      topic,
                      style: const TextStyle(
                        color: AppTheme.whiteText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Figures List
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
                        return _buildFigureCard(context, figures[index], topic);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFigureCard(
    BuildContext context,
    HistoricalFigure figure,
    String topic,
  ) {
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
          // Start Debate Button
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DebateChatScreen(figure: figure, initialTopic: topic),
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
    );
  }
}
