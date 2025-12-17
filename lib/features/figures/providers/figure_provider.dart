import 'package:flutter/foundation.dart';

import '../../../models/historical_figure.dart';
import '../../../services/firestore_service.dart';

class FigureProvider extends ChangeNotifier {
  FigureProvider({FirestoreService? firestore})
      : _firestore = firestore ?? FirestoreService();

  final FirestoreService _firestore;

  List<HistoricalFigure> _figures = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String? _error;

  List<HistoricalFigure> get figures {
    if (_searchQuery.isEmpty) return _figures;
    final lower = _searchQuery.toLowerCase();
    return _figures
        .where(
          (f) =>
              f.name.toLowerCase().contains(lower) ||
              f.title.toLowerCase().contains(lower),
        )
        .toList();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFigures() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _figures = await _firestore.fetchFigures();
      if (_figures.isEmpty) {
        _figures = _fallbackFigures;
      }
    } catch (e) {
      _error = 'Failed to load figures';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  HistoricalFigure? getById(String id) {
    return _figures.firstWhere(
      (figure) => figure.id == id,
      orElse: () => const HistoricalFigure(
        id: 'unknown',
        name: 'Unknown Figure',
        title: '',
        lifespan: '',
        imageUrl: '',
        coreBeliefs: '',
        speechStyle: '',
        keyDecisions: '',
        famousQuote: '',
        modernViews: {},
      ),
    );
  }

  Future<HistoricalFigure> addCustomFigure(String name) async {
    final trimmed = name.trim();
    final figure = HistoricalFigure(
      id: '',
      name: trimmed,
      title: 'Custom Opponent',
      lifespan: '',
      imageUrl: '',
      coreBeliefs:
          '$trimmed is a custom opponent created by the user. Keep responses concise and debate-focused.',
      speechStyle:
          'Speaks clearly, directly, and references historical context when available.',
      keyDecisions: '',
      famousQuote: '',
      modernViews: const {},
    );

    final id = await _firestore.addFigure(figure);
    final saved = HistoricalFigure.fromMap(figure.toMap(), id);
    _figures = [..._figures, saved];
    notifyListeners();
    return saved;
  }

  Future<void> deleteFigure(String id) async {
    await _firestore.deleteFigure(id);
    _figures = _figures.where((f) => f.id != id).toList();
    notifyListeners();
  }

  static const List<HistoricalFigure> _fallbackFigures = [
    HistoricalFigure(
      id: 'lincoln',
      name: 'Abraham Lincoln',
      title: '16th President of the United States',
      lifespan: '1809-1865',
      imageUrl: '',
      coreBeliefs:
          'Believed in preserving the Union, abolishing slavery, and democracy for all citizens.',
      speechStyle:
          'Eloquent, persuasive, using clear language to convey complex ideas.',
      keyDecisions:
          'Emancipation Proclamation, leading the Union through the Civil War.',
      famousQuote:
          'Four score and seven years ago our fathers brought forth on this continent a new nation.',
      modernViews: {
        'Climate Change':
            'Would emphasize the moral imperative to protect future generations.',
      },
    ),
    HistoricalFigure(
      id: 'curie',
      name: 'Marie Curie',
      title: 'Pioneering Physicist and Chemist',
      lifespan: '1867-1934',
      imageUrl: '',
      coreBeliefs: 'Dedicated to scientific discovery and breaking barriers.',
      speechStyle: 'Precise and passionate about scientific inquiry.',
      keyDecisions: 'Discovered radioactivity; first woman to win a Nobel Prize.',
      famousQuote: 'Nothing in life is to be feared, it is only to be understood.',
      modernViews: {
        'Technology':
            'Would emphasize scientific ethics and responsible innovation.',
      },
    ),
  ];
}
