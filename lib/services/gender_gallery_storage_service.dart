import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gender_gallery_image_model.dart';

class GenderGalleryStorageService {
  static const String genderGalleryKey = 'offline_gender_gallery_images_v1';

  static Future<void> saveImages(List<GenderGalleryImageModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final mapped = items.map((e) => e.toMap()).toList();
    final jsonString = jsonEncode(mapped);
    await prefs.setString(genderGalleryKey, jsonString);
  }

  static Future<List<GenderGalleryImageModel>> loadImages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(genderGalleryKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((e) =>
        GenderGalleryImageModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> clearImages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(genderGalleryKey);
  }
}