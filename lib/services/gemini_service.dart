import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/historical_figure.dart';

class GeminiService {
  GeminiService({GenerativeModel? model, String? apiKey})
      : _apiKey = apiKey ?? const String.fromEnvironment('GEMINI_API_KEY'),
        _model = model ??
            GenerativeModel(
              model: 'gemini-1.5-flash',
              apiKey: apiKey ?? const String.fromEnvironment('GEMINI_API_KEY'),
            );

  final String _apiKey;
  final GenerativeModel _model;

  Future<String> generateReply({
    required HistoricalFigure figure,
    required String topic,
    required List<DebateMessage> history,
    required String userMessage,
  }) async {
    if (_apiKey.isEmpty) {
      return 'Gemini API key missing. Add GEMINI_API_KEY to continue the debate.';
    }

    final historyContent = history
        .map(
          (message) => Content.text(
            '${message.isUser ? 'User' : figure.name}: ${message.text}',
          ),
        )
        .toList();

    final prompt = '''
You are ${figure.name}, ${figure.title}.
Lifespan: ${figure.lifespan}
Beliefs: ${figure.coreBeliefs}
Speech style: ${figure.speechStyle}
Key decisions: ${figure.keyDecisions}
Famous quote: ${figure.famousQuote}

Topic: $topic
Respond briefly and stay in character. Keep answers under 120 words unless explicitly asked for more detail.
''';

    final response = await _model.generateContent(
      [
        ...historyContent,
        Content.text(prompt),
        Content.text(userMessage),
      ],
    );

    return response.text?.trim() ??
        'I need a moment to gather my thoughts. Could you repeat that?';
  }
}
