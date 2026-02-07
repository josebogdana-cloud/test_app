import 'package:flutter/material.dart';
import 'matches_screen.dart';
import 'leaderboard_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ScorePredict")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btn(context, "Today's Matches", MatchesScreen()),
            _btn(context, "Leaderboard", LeaderboardScreen()),
            _btn(context, "History", HistoryScreen()),
          ],
        ),
      ),
    );
  }

  Widget _btn(BuildContext context, String text, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: SizedBox(
        width: 220,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          },
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
