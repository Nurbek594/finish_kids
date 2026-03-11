import 'package:flutter/material.dart';
import '../data/parent_tests_data.dart';
import '../models/test_question_model.dart';
import '../theme/app_theme.dart';
import '../services/test_storage_service.dart';
import 'admin_add_test_question_screen.dart';
import 'admin_edit_test_question_screen.dart';

class AdminTestQuestionsScreen extends StatefulWidget {
  final int testType;
  final String testTitle;

  const AdminTestQuestionsScreen({
    super.key,
    required this.testType,
    required this.testTitle,
  });

  @override
  State<AdminTestQuestionsScreen> createState() =>
      _AdminTestQuestionsScreenState();
}

class _AdminTestQuestionsScreenState extends State<AdminTestQuestionsScreen> {
  List<TestQuestionModel> localQuestions = [];
  List<String> localYesNoQuestions = [];
  bool isLoading = true;

  bool get isYesNo => widget.testType == 3;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    if (widget.testType == 1) {
      final saved = await TestStorageService.loadMcqQuestions(1);
      localQuestions = saved ?? List<TestQuestionModel>.from(parentTest1Questions);
    } else if (widget.testType == 2) {
      final saved = await TestStorageService.loadMcqQuestions(2);
      localQuestions = saved ?? List<TestQuestionModel>.from(parentTest2Questions);
    } else {
      final saved = await TestStorageService.loadYesNoQuestions();
      localYesNoQuestions = saved ?? List<String>.from(parentTest3Questions);
    }

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveQuestions() async {
    if (isYesNo) {
      await TestStorageService.saveYesNoQuestions(localYesNoQuestions);
    } else {
      await TestStorageService.saveMcqQuestions(widget.testType, localQuestions);
    }
  }

  Future<void> deleteMcqQuestion(int index) async {
    final deleted = localQuestions[index];

    setState(() {
      localQuestions.removeAt(index);
    });

    await _saveQuestions();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Savol o‘chirildi: ${deleted.question}'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> deleteYesNoQuestion(int index) async {
    final deleted = localYesNoQuestions[index];

    setState(() {
      localYesNoQuestions.removeAt(index);
    });

    await _saveQuestions();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Savol o‘chirildi: $deleted'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> addMcqQuestion(TestQuestionModel question) async {
    setState(() {
      localQuestions.add(question);
    });

    await _saveQuestions();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Yangi savol qo‘shildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Future<void> addYesNoQuestion(String question) async {
    setState(() {
      localYesNoQuestions.add(question);
    });

    await _saveQuestions();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Yangi savol qo‘shildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Future<void> editMcqQuestion(int index, TestQuestionModel question) async {
    setState(() {
      localQuestions[index] = question;
    });

    await _saveQuestions();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Savol yangilandi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Future<void> editYesNoQuestion(int index, String question) async {
    setState(() {
      localYesNoQuestions[index] = question;
    });

    await _saveQuestions();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Savol yangilandi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Future<void> resetQuestions() async {
    await TestStorageService.resetTest(widget.testType);
    await _loadQuestions();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Savollar default holatga qaytarildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = isYesNo ? localYesNoQuestions.length : localQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.testTitle} - Savollar'),
        actions: [
          IconButton(
            onPressed: isLoading ? null : resetQuestions,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6C63FF),
                    Color(0xFF9A8CFF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.quiz_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.testTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$count ta savol mavjud',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: count == 0
                ? const Center(
              child: Text(
                'Savollar mavjud emas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: count,
              itemBuilder: (context, index) {
                if (isYesNo) {
                  final question = localYesNoQuestions[index];

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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                          AppTheme.primaryColor.withOpacity(0.12),
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            question,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'edit') {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AdminEditTestQuestionScreen.yesNo(
                                        question: question,
                                        onSaveYesNo: (newQuestion) {
                                          editYesNoQuestion(index, newQuestion);
                                        },
                                      ),
                                ),
                              );
                            }
                            if (value == 'delete') {
                              await deleteYesNoQuestion(index);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit_rounded),
                                  SizedBox(width: 8),
                                  Text('Tahrirlash'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  SizedBox(width: 8),
                                  Text('O‘chirish'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                final question = localQuestions[index];

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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                        AppTheme.primaryColor.withOpacity(0.12),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.question,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                height: 1.5,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...question.options.map(
                                  (option) => Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  '• ${option.text} (${option.score} ball)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AdminEditTestQuestionScreen.mcq(
                                      question: question,
                                      onSaveMcq: (newQuestion) {
                                        editMcqQuestion(index, newQuestion);
                                      },
                                    ),
                              ),
                            );
                          }
                          if (value == 'delete') {
                            await deleteMcqQuestion(index);
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit_rounded),
                                SizedBox(width: 8),
                                Text('Tahrirlash'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 8),
                                Text('O‘chirish'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => isYesNo
                  ? AdminAddTestQuestionScreen.yesNo(
                onAddYesNo: addYesNoQuestion,
              )
                  : AdminAddTestQuestionScreen.mcq(
                onAddMcq: addMcqQuestion,
              ),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Savol qo‘shish',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}