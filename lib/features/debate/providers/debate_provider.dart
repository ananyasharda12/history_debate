import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../models/historical_figure.dart';
import '../../../services/firestore_service.dart';
import '../../../services/gemini_service.dart';

class DebateProvider extends ChangeNotifier {
  DebateProvider({
    FirestoreService? firestore,
    GeminiService? gemini,
  })  : _firestore = firestore ?? FirestoreService(),
        _gemini = gemini ?? GeminiService();

  final FirestoreService _firestore;
  final GeminiService _gemini;

  List<DebateMessage> _messages = [];
  bool _isSending = false;
  String? _debateId;
  HistoricalFigure? _opponent;
  String _topic = '';
  StreamSubscription<List<DebateMessage>>? _subscription;

  List<DebateMessage> get messages => _messages;
  bool get isSending => _isSending;
  HistoricalFigure? get opponent => _opponent;
  String get topic => _topic;
  String? get debateId => _debateId;

  Future<void> init({
    required HistoricalFigure figure,
    required String topic,
    String? debateId,
  }) async {
    _opponent = figure;
    _topic = topic;

    _subscription?.cancel();

    _debateId = debateId ??
        await _firestore.createDebate(
          topic: topic,
          opponent: figure,
          type: 'USER VS AI',
        );

    final stream = _firestore.watchMessages(_debateId!);
    _messages = await stream.first;
    notifyListeners();

    _subscription = stream.listen((messages) {
      _messages = messages;
      notifyListeners();
    });

    if (_messages.isEmpty) {
      final greeting = DebateMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text:
            'Greetings, I am ${figure.name}. I understand you wish to debate "$topic". Share your perspective and I will respond.',
        isUser: false,
        timestamp: DateTime.now(),
      );
      await _firestore.addMessage(debateId: _debateId!, message: greeting);
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _debateId == null || _opponent == null) {
      return;
    }

    final userMessage = DebateMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    await _firestore.addMessage(
      debateId: _debateId!,
      message: userMessage,
    );

    _isSending = true;
    notifyListeners();

    try {
      final history = [..._messages, userMessage];
      final reply = await _gemini.generateReply(
        figure: _opponent!,
        topic: _topic,
        history: history,
        userMessage: text,
      );

      final aiMessage = DebateMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        text: reply,
        isUser: false,
        timestamp: DateTime.now(),
      );

      await _firestore.addMessage(
        debateId: _debateId!,
        message: aiMessage,
      );
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
