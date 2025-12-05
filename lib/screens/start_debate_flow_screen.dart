import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/historical_figure.dart';
import 'pick_figure_screen.dart';
import 'debate_chat_screen.dart';

class StartDebateFlowScreen extends StatefulWidget {
  const StartDebateFlowScreen({super.key});

  @override
  State<StartDebateFlowScreen> createState() => _StartDebateFlowScreenState();
}

class _StartDebateFlowScreenState extends State<StartDebateFlowScreen> {
  HistoricalFigure? _selectedFigure;
  String _topic = '';

  final TextEditingController _figureController = TextEditingController();

  @override
  void dispose() {
    _figureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.whiteText),
        title: const Text(
          'Start a Debate',
          style: TextStyle(
            color: AppTheme.whiteText,
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepTitle('Step 1', 'Choose Your Opponent'),
            const SizedBox(height: 8),
            _buildFigureInput(context),
            const SizedBox(height: 24),

            _buildStepTitle('Step 2', 'Choose a Topic'),
            const SizedBox(height: 8),
            _buildTopicField(),
            const SizedBox(height: 8),
            const Text(
              'Pick a clear, debate-style question. One or two sentences works best.',
              style: TextStyle(color: AppTheme.lightRed, fontSize: 12),
            ),
            const Spacer(),

            _buildStartDebateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStepTitle(String step, String title) {
    return Row(
      children: [
        Text(
          step,
          style: const TextStyle(
            color: AppTheme.lightRed,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.whiteText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
      ],
    );
  }

  /// Step 1 – type + browse to pick a figure
  Widget _buildFigureInput(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkMaroon,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Type or select a historical figure',
            style: TextStyle(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _figureController,
            style: const TextStyle(color: AppTheme.whiteText),
            cursorColor: AppTheme.brightRed,
            decoration: const InputDecoration(
              hintText: 'e.g. Abraham Lincoln, Cleopatra, Gandhi',
              hintStyle: TextStyle(color: AppTheme.lightRed),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.lightRed),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.brightRed),
              ),
            ),
            onChanged: (_) {
              // If the user edits the text manually, clear any previously selected figure
              setState(() {
                _selectedFigure = null;
              });
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Use Browse to pick from your saved figures.',
                  style: TextStyle(color: AppTheme.lightRed, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () async {
                  final result = await Navigator.push<HistoricalFigure?>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PickFigureScreen(),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      _selectedFigure = result;
                      _figureController.text = result.name;
                    });
                  }
                },
                child: const Text(
                  'Browse',
                  style: TextStyle(
                    color: AppTheme.brightRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Step 2 – topic field
  Widget _buildTopicField() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkMaroon,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: TextField(
        maxLines: 3,
        style: const TextStyle(color: AppTheme.whiteText),
        cursorColor: AppTheme.brightRed,
        decoration: const InputDecoration(
          hintText:
              'e.g. "Should governments prioritize freedom over security?"',
          hintStyle: TextStyle(color: AppTheme.lightRed),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _topic = value;
          });
        },
      ),
    );
  }

  /// Build a figure object based on either the selected figure or typed name.
  HistoricalFigure? _getFigureForDebate() {
    final name = _figureController.text.trim();
    if (name.isEmpty) return null;

    // If user chose from Browse, use that full model.
    if (_selectedFigure != null) return _selectedFigure;

    // Otherwise create a lightweight figure using just the typed name.
    return HistoricalFigure(
      id: 'custom_${name.toLowerCase().replaceAll(' ', '_')}',
      name: name,
      title: 'Debate Opponent',
      lifespan: '',
      imageUrl: '',
      coreBeliefs:
          '$name is being treated as a custom debate opponent created from the name you typed.',
      speechStyle:
          'Responds in a reasoned, debate-oriented style appropriate for the discussion.',
      keyDecisions: '',
      famousQuote: '',
      modernViews: const {},
    );
  }

  /// Start button – works when there is a figure name + topic
  Widget _buildStartDebateButton(BuildContext context) {
    final hasFigureName = _figureController.text.trim().isNotEmpty;
    final hasTopic = _topic.trim().isNotEmpty;
    final bool isEnabled = hasFigureName && hasTopic;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                final figure = _getFigureForDebate();
                if (figure == null) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DebateChatScreen(
                      figure: figure,
                      initialTopic: _topic.trim(),
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppTheme.brightRed : AppTheme.darkMaroon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Start Debate',
          style: TextStyle(
            color: AppTheme.whiteText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
      ),
    );
  }
}
