import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/historical_figure.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? instance})
      : _db = instance ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  // Figures
  Future<List<HistoricalFigure>> fetchFigures() async {
    final snapshot = await _db.collection('figures').orderBy('name').get();
    return snapshot.docs
        .map((doc) => HistoricalFigure.fromMap(doc.data(), doc.id))
        .toList();
  }

  Stream<List<HistoricalFigure>> watchFigures() {
    return _db.collection('figures').orderBy('name').snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => HistoricalFigure.fromMap(doc.data(), doc.id))
            .toList();
      },
    );
  }

  Future<String> addFigure(HistoricalFigure figure) async {
    final doc = await _db.collection('figures').add(figure.toMap());
    return doc.id;
  }

  Future<void> updateFigure(HistoricalFigure figure) {
    return _db.collection('figures').doc(figure.id).update(figure.toMap());
  }

  Future<void> deleteFigure(String id) {
    return _db.collection('figures').doc(id).delete();
  }

  // Debates + messages
  Future<String> createDebate({
    required String topic,
    required HistoricalFigure opponent,
    required String type,
  }) async {
    final doc = await _db.collection('debates').add({
      'title': topic,
      'description': 'Debate with ${opponent.name}',
      'type': type,
      'createdAt': DateTime.now(),
      'figures': [
        opponent.toMap()..['id'] = opponent.id,
      ],
    });
    return doc.id;
  }

  Future<void> addMessage({
    required String debateId,
    required DebateMessage message,
  }) {
    return _db
        .collection('debates')
        .doc(debateId)
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());
  }

  Stream<List<DebateMessage>> watchMessages(String debateId) {
    return _db
        .collection('debates')
        .doc(debateId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => DebateMessage.fromMap(doc.data(), doc.id))
            .toList();
      },
    );
  }

  Future<List<Debate>> fetchDebates() async {
    final snapshot =
        await _db.collection('debates').orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => Debate.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> deleteDebate(String id) {
    return _db.collection('debates').doc(id).delete();
  }
}
