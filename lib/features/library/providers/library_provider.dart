import 'package:flutter/foundation.dart';

import '../../../models/historical_figure.dart';
import '../../../services/firestore_service.dart';

class LibraryProvider extends ChangeNotifier {
  LibraryProvider({FirestoreService? firestore})
      : _firestore = firestore ?? FirestoreService();

  final FirestoreService _firestore;

  List<Debate> _debates = [];
  bool _isLoading = false;
  String _query = '';
  String? _error;

  List<Debate> get debates {
    if (_query.isEmpty) return _debates;
    final lower = _query.toLowerCase();
    return _debates
        .where(
          (debate) =>
              debate.title.toLowerCase().contains(lower) ||
              debate.description.toLowerCase().contains(lower),
        )
        .toList();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDebates() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _debates = await _firestore.fetchDebates();
    } catch (e) {
      _error = 'Failed to load debates';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  Future<void> deleteDebate(String id) async {
    await _firestore.deleteDebate(id);
    _debates = _debates.where((debate) => debate.id != id).toList();
    notifyListeners();
  }
}
