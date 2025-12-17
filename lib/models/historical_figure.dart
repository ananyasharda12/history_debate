import 'package:cloud_firestore/cloud_firestore.dart';

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
  final Map<String, String> modernViews;

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

  factory HistoricalFigure.fromMap(Map<String, dynamic> data, String id) {
    return HistoricalFigure(
      id: id,
      name: data['name'] as String? ?? '',
      title: data['title'] as String? ?? '',
      lifespan: data['lifespan'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      coreBeliefs: data['coreBeliefs'] as String? ?? '',
      speechStyle: data['speechStyle'] as String? ?? '',
      keyDecisions: data['keyDecisions'] as String? ?? '',
      famousQuote: data['famousQuote'] as String? ?? '',
      modernViews: Map<String, String>.from(
        (data['modernViews'] as Map?) ?? <String, String>{},
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'lifespan': lifespan,
      'imageUrl': imageUrl,
      'coreBeliefs': coreBeliefs,
      'speechStyle': speechStyle,
      'keyDecisions': keyDecisions,
      'famousQuote': famousQuote,
      'modernViews': modernViews,
    };
  }
}

class DebateMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? avatarUrl;

  const DebateMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.avatarUrl,
  });

  factory DebateMessage.fromMap(Map<String, dynamic> data, String id) {
    return DebateMessage(
      id: id,
      text: data['text'] as String? ?? '',
      isUser: data['isUser'] as bool? ?? false,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(
            (data['timestamp'] as int?) ?? 0,
          ),
      avatarUrl: data['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp,
      'avatarUrl': avatarUrl,
    };
  }
}

class Debate {
  final String id;
  final String title;
  final String description;
  final String type;
  final String? thumbnailUrl;
  final DateTime createdAt;
  final List<HistoricalFigure>? figures;

  const Debate({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.thumbnailUrl,
    required this.createdAt,
    this.figures,
  });

  factory Debate.fromMap(Map<String, dynamic> data, String id) {
    return Debate(
      id: id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      type: data['type'] as String? ?? 'USER VS AI',
      thumbnailUrl: data['thumbnailUrl'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(
            (data['createdAt'] as int?) ??
                DateTime.now().millisecondsSinceEpoch,
          ),
      figures: (data['figures'] as List?)
          ?.map(
            (entry) => HistoricalFigure.fromMap(
              Map<String, dynamic>.from(entry as Map),
              entry['id'] as String? ?? '',
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt,
      if (figures != null)
        'figures':
            figures!.map((figure) => figure.toMap()..['id'] = figure.id).toList(),
    };
  }
}
