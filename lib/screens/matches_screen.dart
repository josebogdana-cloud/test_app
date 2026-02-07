import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'prediction_screen.dart';

class MatchesScreen extends StatefulWidget {
  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List all = [];
  List filtered = [];

  String country = "All";
  String league = "All";
  bool liveOnly = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    all = await ApiService.getTodayFixtures();
    apply();
  }

  void apply() {
    final now = DateTime.now();

    filtered = all.where((m) {
      final status = m["fixture"]["status"]["short"];
      final date = DateTime.parse(m["fixture"]["date"]);

      const finished = ["FT", "AET", "PEN", "CANC", "PST", "ABD"];
      if (finished.contains(status)) return false;

      if (date.difference(now).inMinutes <= 5) return false;

      if (country != "All" && m["league"]["country"] != country) return false;
      if (league != "All" && m["league"]["name"] != league) return false;
      if (liveOnly && status != "LIVE") return false;

      return true;
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final countries = {"All", ...all.map((e) => e["league"]["country"] as String)};
    final leagues = {
      "All",
      ...all
          .where((e) => country == "All" || e["league"]["country"] == country)
          .map((e) => e["league"]["name"] as String)
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Today's Matches")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: country,
                  isExpanded: true,
                  items: countries
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (String? v) {
                    if (v == null) return;
                    setState(() {
                      country = v;
                      league = "All";
                      apply();
                    });
                  },
                ),
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: league,
                  isExpanded: true,
                  items: leagues
                      .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                      .toList(),
                  onChanged: (String? v) {
                    if (v == null) return;
                    setState(() {
                      league = v;
                      apply();
                    });
                  },
                ),
              ),
              Switch(
                value: liveOnly,
                onChanged: (v) {
                  setState(() {
                    liveOnly = v;
                    apply();
                  });
                },
              )
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final m = filtered[i];

                return Card(
                  child: ListTile(
                    leading: Image.network(m["teams"]["home"]["logo"], width: 32),
                    title: Text("${m["teams"]["home"]["name"]} vs ${m["teams"]["away"]["name"]}"),
                    subtitle: Text(m["fixture"]["status"]["short"]),
                    trailing: Image.network(m["teams"]["away"]["logo"], width: 32),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PredictionScreen(
                          id: m["fixture"]["id"].toString(),
                          home: m["teams"]["home"]["name"],
                          away: m["teams"]["away"]["name"],
                          kickoff: m["fixture"]["date"],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
