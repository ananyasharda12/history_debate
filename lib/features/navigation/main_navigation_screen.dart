import 'package:flutter/material.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../home/home_screen_content.dart';
import '../debate/historical_debate_screen.dart';
import '../figures/figures_browse_screen.dart';
import '../library/library_screen_content.dart';
import '../profile/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreenContent(), // Index 0: Home
          HistoricalDebateScreen(), // Index 1: Debate
          LibraryScreenContent(), // Index 2: Library
          FiguresBrowseScreen(), // Index 3: Figures
          SettingsScreen(), // Index 4: Profile
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
