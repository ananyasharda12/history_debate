import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/historical_figure.dart';
import '../../theme/app_theme.dart';
import 'historical_figure_profile_screen.dart';
import 'providers/figure_provider.dart';

class FiguresBrowseScreen extends StatelessWidget {
  const FiguresBrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final figureProvider = context.watch<FigureProvider>();
    final figures = figureProvider.figures;

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
                  style: TextStyle(color: AppTheme.lightGray, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Figures Grid
            Expanded(
              child: figureProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.brightRed,
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: figures.length,
                      itemBuilder: (context, index) {
                        return _buildFigureCard(context, figures[index]);
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
            builder: (context) => HistoricalFigureProfileScreen(figure: figure),
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
