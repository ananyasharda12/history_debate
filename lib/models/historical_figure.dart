class HistoricalFigure {
  final String id;
  final String name;
  final String title;
  final String lifespan;
  final String imageUrl;
  final String coreBeliefs;
  final String speechStyle;
  final String keyDecisions;
  final String famousQuote;
  final Map<String, String> modernViews; // topic -> view

  const HistoricalFigure({
    required this.id,
    required this.name,
    required this.title,
    required this.lifespan,
    required this.imageUrl,
    required this.coreBeliefs,
    required this.speechStyle,
    required this.keyDecisions,
    required this.famousQuote,
    required this.modernViews,
  });
}

class DebateMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? avatarUrl;

  DebateMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.avatarUrl,
  });
}

class Debate {
  final String id;
  final String title;
  final String description;
  final String type; // "AI VS AI" or "USER VS AI"
  final String? thumbnailUrl;
  final DateTime createdAt;
  final List<HistoricalFigure>? figures;

  Debate({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.thumbnailUrl,
    required this.createdAt,
    this.figures,
  });
}

