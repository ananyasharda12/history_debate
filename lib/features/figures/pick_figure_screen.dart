import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/historical_figure.dart';
import '../../theme/app_theme.dart';
import 'historical_figure_profile_screen.dart';
import 'providers/figure_provider.dart';

class PickFigureScreen extends StatelessWidget {
  const PickFigureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final figureProvider = context.watch<FigureProvider>();
    final figures = figureProvider.figures;

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
                onChanged: figureProvider.setSearchQuery,
              ),
            ),

            // Figures Grid
            Expanded(
              child: figureProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.brightRed,
                      ),
                    )
                  : figureProvider.error != null
                       ? Center(
                           child: Text(
                             figureProvider.error!,
                             style: const TextStyle(color: AppTheme.lightGray),
                           ),
                         )
                       : figures.isEmpty
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
                               itemCount: figures.length,
                               itemBuilder: (context, index) {
                                 return _buildFigureCard(
                                   context,
                                   figures[index],
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
