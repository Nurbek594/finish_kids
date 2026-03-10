import 'test_option_model.dart';

class TestQuestionModel {
  final String question;
  final List<TestOptionModel> options;

  const TestQuestionModel({
    required this.question,
    required this.options,
  });
}