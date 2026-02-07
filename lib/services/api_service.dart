import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = "ad9b06264401428a23f4e120098328f3";

  static Future<List> getTodayFixtures() async {
    final today = DateTime.now().toIso8601String().split("T")[0];

    final res = await http.get(
      Uri.parse("https://v3.football.api-sports.io/fixtures?date=$today"),
      headers: {"x-apisports-key": apiKey},
    );

    final data = jsonDecode(res.body);
    return data["response"] ?? [];
  }
}