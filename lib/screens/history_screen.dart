import 'package:flutter/material.dart';
import '../services/prediction_storage.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    data = await PredictionStorage.getPredictions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) {
          final p = data[i];
          return Card(
            child: ListTile(
              title: Text("${p["home"]} vs ${p["away"]}"),
              subtitle: Text("${p["homeScore"]} - ${p["awayScore"]}"),
            ),
          );
        },
      ),
    );
  }
}
