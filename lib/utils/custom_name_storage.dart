import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CustomNameStorage {
  static Future<Map<String, String>> loadCustomNames() async {
    final prefs = await SharedPreferences.getInstance();
    final customNamesString = prefs.getString('customNames') ?? '{}';
    return Map<String, String>.from(json.decode(customNamesString));
  }

  static Future<void> saveCustomNames(Map<String, String> customNames) async {
    final prefs = await SharedPreferences.getInstance();
    final customNamesString = json.encode(customNames);
    await prefs.setString('customNames', customNamesString);
  }
}