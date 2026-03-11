import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/parent_tests_data.dart';
import '../models/test_option_model.dart';
import '../models/test_question_model.dart';

class TestStorageService {
  static const String test1Key = 'offline_test_1_questions_v1';
  static const String test2Key = 'offline_test_2_questions_v1';
  static const String test3Key = 'offline_test_3_questions_v1';

  static Future<void> saveMcqQuestions(
      int testType,
      List<TestQuestionModel> questions,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final mapped = questions
        .map(
          (q) => {
        'question': q.question,
        'options': q.options
            .map(
              (o) => {
            'text': o.text,
            'score': o.score,
          },
        )
            .toList(),
      },
    )
        .toList();

    final jsonString = jsonEncode(mapped);

    if (testType == 1) {
      await prefs.setString(test1Key, jsonString);
    } else if (testType == 2) {
      await prefs.setString(test2Key, jsonString);
    }
  }

  static Future<List<TestQuestionModel>?> loadMcqQuestions(int testType) async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString;
    if (testType == 1) {
      jsonString = prefs.getString(test1Key);
    } else if (testType == 2) {
      jsonString = prefs.getString(test2Key);
    }

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded.map((item) {
      final map = Map<String, dynamic>.from(item);
      final List<dynamic> optionsRaw = map['options'] ?? [];

      return TestQuestionModel(
        question: map['question'] ?? '',
        options: optionsRaw.map((option) {
          final optionMap = Map<String, dynamic>.from(option);
          return TestOptionModel(
            text: optionMap['text'] ?? '',
            score: optionMap['score'] ?? 1,
          );
        }).toList(),
      );
    }).toList();
  }

  static Future<void> saveYesNoQuestions(List<String> questions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(questions);
    await prefs.setString(test3Key, jsonString);
  }

  static Future<List<String>?> loadYesNoQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(test3Key);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => e.toString()).toList();
  }

  static Future<void> resetTest(int testType) async {
    final prefs = await SharedPreferences.getInstance();

    if (testType == 1) {
      await saveMcqQuestions(1, parentTest1Questions);
    } else if (testType == 2) {
      await saveMcqQuestions(2, parentTest2Questions);
    } else {
      await saveYesNoQuestions(parentTest3Questions);
    }
  }
}