import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/who_am_i_data.dart';
import '../models/who_am_i_item_model.dart';

class WhoAmIStorageService {
  static const String toysKey = 'offline_who_am_i_toys_v1';
  static const String jobsKey = 'offline_who_am_i_jobs_v1';

  static Future<void> saveToys(List<WhoAmIItemModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
    jsonEncode(items.map((e) => e.toMap()).toList());
    await prefs.setString(toysKey, jsonString);
  }

  static Future<void> saveJobs(List<WhoAmIItemModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
    jsonEncode(items.map((e) => e.toMap()).toList());
    await prefs.setString(jobsKey, jsonString);
  }

  static Future<List<WhoAmIItemModel>> loadToys() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(toysKey);

    if (jsonString == null || jsonString.isEmpty) {
      return List<WhoAmIItemModel>.from(toyItems);
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((e) => WhoAmIItemModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<List<WhoAmIItemModel>> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(jobsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return List<WhoAmIItemModel>.from(jobItems);
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((e) => WhoAmIItemModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(toysKey);
    await prefs.remove(jobsKey);
  }
}