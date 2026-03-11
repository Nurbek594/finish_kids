import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/story_model.dart';

class StoryStorageService {
  static const String storiesKey = 'offline_admin_stories_v1';

  static Future<void> saveStories(List<StoryModel> stories) async {
    final prefs = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> mapped =
    stories.map((story) => story.toMap()).toList();

    final jsonString = jsonEncode(mapped);
    await prefs.setString(storiesKey, jsonString);
  }

  static Future<List<StoryModel>?> loadStories() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storiesKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded
        .map((item) => StoryModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<void> clearStories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(storiesKey);
  }
}