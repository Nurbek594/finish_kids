import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/parent_tip_model.dart';

class ParentTipStorageService {
  static const String tipsKey = 'offline_parent_tips_v1';

  static Future<void> saveTips(List<ParentTipModel> tips) async {
    final prefs = await SharedPreferences.getInstance();

    final mapped = tips.map((tip) => tip.toMap()).toList();
    final jsonString = jsonEncode(mapped);

    await prefs.setString(tipsKey, jsonString);
  }

  static Future<List<ParentTipModel>?> loadTips() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(tipsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded
        .map((item) => ParentTipModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<void> clearTips() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tipsKey);
  }
}