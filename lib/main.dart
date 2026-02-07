import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ScorePredictApp());
}

class ScorePredictApp extends StatelessWidget {
  const ScorePredictApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScorePredict',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF0F1115),

        cardTheme: const CardThemeData(
          elevation: 6,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
      ),

      home: HomeScreen(), // ❌ PAS const
    );
  }
}
