import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PredictionStorage {
  static const key = "predictions";

  static Future<List<Map<String, dynamic>>> getPredictions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);

    if (raw == null) return [];

    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> save(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getPredictions();

    list.removeWhere((e) => e["id"] == item["id"]);
    list.add(item);

    await prefs.setString(key, jsonEncode(list));
  }
}
