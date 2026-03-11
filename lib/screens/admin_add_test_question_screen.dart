import 'package:flutter/material.dart';
import '../models/test_option_model.dart';
import '../models/test_question_model.dart';
import '../theme/app_theme.dart';

class AdminAddTestQuestionScreen extends StatefulWidget {
  final void Function(TestQuestionModel)? onAddMcq;
  final void Function(String)? onAddYesNo;
  final bool isYesNo;

  const AdminAddTestQuestionScreen.mcq({
    super.key,
    required this.onAddMcq,
  })  : onAddYesNo = null,
        isYesNo = false;

  const AdminAddTestQuestionScreen.yesNo({
    super.key,
    required this.onAddYesNo,
  })  : onAddMcq = null,
        isYesNo = true;

  @override
  State<AdminAddTestQuestionScreen> createState() =>
      _AdminAddTestQuestionScreenState();
}

class _AdminAddTestQuestionScreenState
    extends State<AdminAddTestQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();

  void save() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.isYesNo) {
      widget.onAddYesNo?.call(_questionController.text.trim());
    } else {
      final question = TestQuestionModel(
        question: _questionController.text.trim(),
        options: [
          TestOptionModel(
            text: _option1Controller.text.trim(),
            score: 1,
          ),
          TestOptionModel(
            text: _option2Controller.text.trim(),
            score: 2,
          ),
          TestOptionModel(
            text: _option3Controller.text.trim(),
            score: 3,
          ),
        ],
      );
      widget.onAddMcq?.call(question);
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppTheme.primaryColor,
          width: 1.4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isYesNo
            ? 'Ha/Yo‘q savol qo‘shish'
            : 'Yangi savol qo‘shish'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: [
            TextFormField(
              controller: _questionController,
              maxLines: 3,
              decoration: inputDecoration(
                'Savol',
                Icons.help_outline_rounded,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Savol kiriting';
                }
                return null;
              },
            ),
            if (!widget.isYesNo) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _option1Controller,
                decoration: inputDecoration(
                  '1-variant (1 ball)',
                  Icons.looks_one_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '1-variantni kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _option2Controller,
                decoration: inputDecoration(
                  '2-variant (2 ball)',
                  Icons.looks_two_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '2-variantni kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _option3Controller,
                decoration: inputDecoration(
                  '3-variant (3 ball)',
                  Icons.looks_3_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '3-variantni kiriting';
                  }
                  return null;
                },
              ),
            ],
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: save,
                icon: const Icon(Icons.save_rounded),
                label: const Text(
                  'Saqlash',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}