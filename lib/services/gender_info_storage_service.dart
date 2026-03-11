import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gender_info_model.dart';

class GenderInfoStorageService {
  static const String genderInfoKey = 'offline_gender_info_v1';

  static Future<void> saveGenderInfos(List<GenderInfoModel> items) async {
    final prefs = await SharedPreferences.getInstance();

    final mapped = items.map((item) => item.toMap()).toList();
    final jsonString = jsonEncode(mapped);

    await prefs.setString(genderInfoKey, jsonString);
  }

  static Future<List<GenderInfoModel>?> loadGenderInfos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(genderInfoKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded
        .map((item) => GenderInfoModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<void> clearGenderInfos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(genderInfoKey);
  }
}