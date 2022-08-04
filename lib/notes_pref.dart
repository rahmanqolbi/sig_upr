import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotesPref {
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key) ?? '[]');
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }
}
