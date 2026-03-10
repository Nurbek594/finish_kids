import 'package:flutter/material.dart';
import '../data/parent_tests_data.dart';
import '../models/test_question_model.dart';
import '../theme/app_theme.dart';
import 'parent_test_result_screen.dart';

class ParentTestMcqScreen extends StatefulWidget {
  final int testType;

  const ParentTestMcqScreen({
    super.key,
    required this.testType,
  });

  @override
  State<ParentTestMcqScreen> createState() => _ParentTestMcqScreenState();
}

class _ParentTestMcqScreenState extends State<ParentTestMcqScreen> {
  final Map<int, int> selectedAnswers = {};

  List<TestQuestionModel> get questions {
    if (widget.testType == 1) {
      return parentTest1Questions;
    } else {
      return parentTest2Questions;
    }
  }

  String get screenTitle {
    if (widget.testType == 1) {
      return '1-test';
    } else {
      return '2-test';
    }
  }

  String get screenSubtitle {
    if (widget.testType == 1) {
      return 'Gender identifikatsiyasi shakllanishidagi tarbiya yondoshuvi';
    } else {
      return 'Oiladagi pedagogik xulq-atvor uslubi';
    }
  }

  void finishTest() {
    if (selectedAnswers.length != questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Barcha savollarga javob bering'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
      return;
    }

    int totalScore = 0;

    for (int i = 0; i < questions.length; i++) {
      final selectedOptionIndex = selectedAnswers[i]!;
      totalScore += questions[i].options[selectedOptionIndex].score;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ParentTestResultScreen(
          testType: widget.testType,
          totalScore: totalScore,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color topColor =
    widget.testType == 1 ? const Color(0xFF7C5CFF) : const Color(0xFFFF8A65);
    final Color endColor =
    widget.testType == 1 ? const Color(0xFFB26BFF) : const Color(0xFFFFC371);

    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [topColor, endColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: topColor.withOpacity(0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    screenTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    screenSubtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textDark,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(question.options.length, (optionIndex) {
                        final option = question.options[optionIndex];
                        final bool isSelected =
                            selectedAnswers[index] == optionIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAnswers[index] = optionIndex;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryColor.withOpacity(0.08)
                                  : const Color(0xFFF8F9FB),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : Colors.grey.shade200,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: isSelected
                                      ? AppTheme.primaryColor
                                      : Colors.grey.shade300,
                                  child: isSelected
                                      ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    option.text,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: finishTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Natijani ko‘rish',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}