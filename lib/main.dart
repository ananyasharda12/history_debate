import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:history_debate/firebase_options.dart';
import 'package:provider/provider.dart';

import 'features/figures/providers/figure_provider.dart';
import 'features/library/providers/library_provider.dart';
import 'theme/app_theme.dart';
import 'features/navigation/main_navigation_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DebateAIApp());
}

class DebateAIApp extends StatelessWidget {
  const DebateAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FigureProvider()..loadFigures(),
        ),
        ChangeNotifierProvider(
          create: (_) => LibraryProvider()..loadDebates(),
        ),
      ],
      child: MaterialApp(
        title: 'Debate AI',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
