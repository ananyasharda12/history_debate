import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/historical_figure.dart';
import 'historical_figure_profile_screen.dart';

class FiguresBrowseScreen extends StatelessWidget {
  const FiguresBrowseScreen({super.key});

  static final List<HistoricalFigure> _figures = [
    const HistoricalFigure(
      id: '1',
      name: 'Abraham Lincoln',
      title: '16th President of the United States',
      lifespan: '1809-1865',
      imageUrl: '',
      coreBeliefs: 'Lincoln believed in the preservation of the Union, the abolition of slavery, and the importance of democracy and equality for all citizens.',
      speechStyle: 'Lincoln was known for his eloquent and persuasive speeches, often using clear and concise language to convey complex ideas.',
      keyDecisions: "Lincoln's key decisions include issuing the Emancipation Proclamation, leading the Union through the Civil War, and delivering the Gettysburg Address.",
      famousQuote: 'Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.',
      modernViews: {
        'Climate Change': 'Lincoln would likely emphasize the moral imperative to protect future generations and the need for collective action.',
        'Healthcare': 'Lincoln would likely advocate for a system that ensures access to healthcare for all citizens, emphasizing social responsibility.',
      },
    ),
    const HistoricalFigure(
      id: '2',
      name: 'Marie Curie',
      title: 'Pioneering Physicist and Chemist',
      lifespan: '1867-1934',
      imageUrl: '',
      coreBeliefs: 'Curie was dedicated to scientific discovery and breaking barriers for women in science.',
      speechStyle: 'Curie spoke with precision and passion about scientific inquiry and the pursuit of knowledge.',
      keyDecisions: 'Curie\'s key achievements include discovering radioactivity and being the first woman to win a Nobel Prize.',
      famousQuote: 'Nothing in life is to be feared, it is only to be understood.',
      modernViews: {
        'Technology': 'Curie would likely emphasize the importance of scientific ethics and responsible innovation.',
      },
    ),
    const HistoricalFigure(
      id: '3',
      name: 'Leonardo da Vinci',
      title: 'Renaissance Polymath',
      lifespan: '1452-1519',
      imageUrl: '',
      coreBeliefs: 'Da Vinci believed in the interconnectedness of art, science, and nature.',
      speechStyle: 'Da Vinci communicated through detailed observations and interdisciplinary thinking.',
      keyDecisions: 'Da Vinci\'s contributions include the Mona Lisa, The Last Supper, and numerous scientific inventions.',
      famousQuote: 'Learning never exhausts the mind.',
      modernViews: {
        'Innovation': 'Da Vinci would likely advocate for interdisciplinary approaches to solving modern problems.',
      },
    ),
    const HistoricalFigure(
      id: '4',
      name: 'Cleopatra',
      title: 'Last Active Ruler of Ptolemaic Egypt',
      lifespan: '69-30 BC',
      imageUrl: '',
      coreBeliefs: 'Cleopatra was a skilled diplomat and strategist focused on preserving her kingdom.',
      speechStyle: 'Cleopatra was known for her persuasive rhetoric and strategic communication.',
      keyDecisions: 'Cleopatra\'s key decisions include forming alliances with Rome and maintaining Egypt\'s independence.',
      famousQuote: 'I will not be triumphed over.',
      modernViews: {
        'Leadership': 'Cleopatra would likely emphasize the importance of strategic alliances and cultural diplomacy.',
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Historical Figures',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: AppTheme.whiteText),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explore and learn about historical figures',
                  style: TextStyle(
                    color: AppTheme.lightGray,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Figures Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: _figures.length,
                itemBuilder: (context, index) {
                  return _buildFigureCard(context, _figures[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFigureCard(BuildContext context, HistoricalFigure figure) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoricalFigureProfileScreen(
              figure: figure,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Portrait
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
            // Info
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
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      figure.lifespan,
                      style: const TextStyle(
                        color: AppTheme.mediumGray,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


