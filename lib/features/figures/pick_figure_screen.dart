import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/historical_figure.dart';
import 'historical_figure_profile_screen.dart';

class PickFigureScreen extends StatefulWidget {
  const PickFigureScreen({super.key});

  // Master list of available figures
  static final List<HistoricalFigure> figures = [
    const HistoricalFigure(
      id: '1',
      name: 'Abraham Lincoln',
      title: '16th President of the United States',
      lifespan: '1809-1865',
      imageUrl: '',
      coreBeliefs:
          'Lincoln believed in the preservation of the Union, the abolition of slavery, and the importance of democracy and equality for all citizens.',
      speechStyle:
          'Lincoln was known for his eloquent and persuasive speeches, often using clear and concise language to convey complex ideas.',
      keyDecisions:
          "Lincoln's key decisions include issuing the Emancipation Proclamation, leading the Union through the Civil War, and delivering the Gettysburg Address.",
      famousQuote:
          'Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.',
      modernViews: {
        'Climate Change':
            'Lincoln would likely emphasize the moral imperative to protect future generations and the need for collective action.',
        'Healthcare':
            'Lincoln would likely advocate for a system that ensures access to healthcare for all citizens, emphasizing social responsibility.',
      },
    ),
    const HistoricalFigure(
      id: '2',
      name: 'Marie Curie',
      title: 'Pioneering Physicist and Chemist',
      lifespan: '1867-1934',
      imageUrl: '',
      coreBeliefs:
          'Curie was dedicated to scientific discovery and breaking barriers for women in science.',
      speechStyle:
          'Curie spoke with precision and passion about scientific inquiry and the pursuit of knowledge.',
      keyDecisions:
          "Curie's key achievements include discovering radioactivity and being the first woman to win a Nobel Prize.",
      famousQuote:
          'Nothing in life is to be feared, it is only to be understood.',
      modernViews: {
        'Technology':
            'Curie would likely emphasize the importance of scientific ethics and responsible innovation.',
      },
    ),
    const HistoricalFigure(
      id: '3',
      name: 'Leonardo da Vinci',
      title: 'Renaissance Polymath',
      lifespan: '1452-1519',
      imageUrl: '',
      coreBeliefs:
          'Da Vinci believed in the interconnectedness of art, science, and nature.',
      speechStyle:
          'Da Vinci communicated through detailed observations and interdisciplinary thinking.',
      keyDecisions:
          "Da Vinci's contributions include the Mona Lisa, The Last Supper, and numerous scientific inventions.",
      famousQuote: 'Learning never exhausts the mind.',
      modernViews: {
        'Innovation':
            'Da Vinci would likely advocate for interdisciplinary approaches to solving modern problems.',
      },
    ),
    const HistoricalFigure(
      id: '4',
      name: 'Cleopatra',
      title: 'Last Active Ruler of Ptolemaic Egypt',
      lifespan: '69-30 BC',
      imageUrl: '',
      coreBeliefs:
          'Cleopatra was a skilled diplomat and strategist focused on preserving her kingdom.',
      speechStyle:
          'Cleopatra was known for her persuasive rhetoric and strategic communication.',
      keyDecisions:
          "Cleopatra's key decisions include forming alliances with Rome and maintaining Egypt's independence.",
      famousQuote: 'I will not be triumphed over.',
      modernViews: {
        'Leadership':
            'Cleopatra would likely emphasize the importance of strategic alliances and cultural diplomacy.',
      },
    ),
  ];

  @override
  State<PickFigureScreen> createState() => _PickFigureScreenState();
}

class _PickFigureScreenState extends State<PickFigureScreen> {
  late List<HistoricalFigure> _filteredFigures;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredFigures = List.from(PickFigureScreen.figures);
  }

  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query;
      final lower = query.toLowerCase().trim();

      if (lower.isEmpty) {
        _filteredFigures = List.from(PickFigureScreen.figures);
      } else {
        _filteredFigures = PickFigureScreen.figures.where((figure) {
          final name = figure.name.toLowerCase();
          final title = figure.title.toLowerCase();
          return name.contains(lower) || title.contains(lower);
        }).toList();
      }
    });
  }

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
        title: const Text(
          'Choose Your Opponent',
          style: TextStyle(
            color: AppTheme.whiteText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Subtitle
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explore the minds that shaped history and pick who you’ll debate.',
                  style: TextStyle(color: AppTheme.lightGray, fontSize: 14),
                ),
              ),
            ),

            // Search / type-a-figure bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: TextField(
                style: const TextStyle(color: AppTheme.whiteText),
                cursorColor: AppTheme.brightRed,
                decoration: InputDecoration(
                  hintText: 'Type or search a figure (e.g. Lincoln, Curie)...',
                  hintStyle: const TextStyle(
                    color: AppTheme.lightGray,
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: AppTheme.darkCard,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppTheme.lightGray,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),
                ),
                onChanged: _updateSearch,
              ),
            ),

            // Figures Grid
            Expanded(
              child: _filteredFigures.isEmpty
                  ? const Center(
                      child: Text(
                        'No figures match your search.',
                        style: TextStyle(
                          color: AppTheme.lightGray,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.65,
                          ),
                      itemCount: _filteredFigures.length,
                      itemBuilder: (context, index) {
                        return _buildFigureCard(
                          context,
                          _filteredFigures[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFigureCard(BuildContext context, HistoricalFigure figure) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Portrait placeholder
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.darkMaroon,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 60,
                color: AppTheme.whiteText,
              ),
            ),
          ),
          // Info + actions
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    figure.name,
                    style: const TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    figure.title,
                    style: const TextStyle(
                      color: AppTheme.lightGray,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HistoricalFigureProfileScreen(
                                        figure: figure,
                                      ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.darkMaroon,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'View',
                              style: TextStyle(
                                color: AppTheme.whiteText,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {
                              // Return this figure to StartDebateFlowScreen
                              Navigator.pop(context, figure);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.brightRed,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Select',
                              style: TextStyle(
                                color: AppTheme.whiteText,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
