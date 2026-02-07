import 'package:flutter/material.dart';
import '../services/prediction_storage.dart';

class PredictionScreen extends StatefulWidget {
  final String id;
  final String home;
  final String away;
  final String kickoff;

  PredictionScreen({
    required this.id,
    required this.home,
    required this.away,
    required this.kickoff,
  });

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  int homeScore = 0;
  int awayScore = 0;

  Future<void> save() async {
    await PredictionStorage.savePrediction(
      widget.id,
      widget.home,
      widget.away,
      widget.kickoff,
      homeScore,
      awayScore,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prediction")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.home),
          _counter(true),
          Text(widget.away),
          _counter(false),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: save,
            child: const Text("Save Prediction"),
          )
        ],
      ),
    );
  }

  Widget _counter(bool home) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: const Icon(Icons.remove), onPressed: () {
          setState(() {
            if (home && homeScore > 0) homeScore--;
            if (!home && awayScore > 0) awayScore--;
          });
        }),
        Text(home ? "$homeScore" : "$awayScore"),
        IconButton(icon: const Icon(Icons.add), onPressed: () {
          setState(() {
            if (home) homeScore++;
            else awayScore++;
          });
        }),
      ],
    );
  }
}
