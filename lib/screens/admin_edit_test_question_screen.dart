import 'package:flutter/material.dart';
import '../models/test_option_model.dart';
import '../models/test_question_model.dart';
import '../theme/app_theme.dart';

class AdminEditTestQuestionScreen extends StatefulWidget {
  final TestQuestionModel? question;
  final String? yesNoQuestion;
  final void Function(TestQuestionModel)? onSaveMcq;
  final void Function(String)? onSaveYesNo;
  final bool isYesNo;

  const AdminEditTestQuestionScreen.mcq({
    super.key,
    required this.question,
    required this.onSaveMcq,
  })  : yesNoQuestion = null,
        onSaveYesNo = null,
        isYesNo = false;

  const AdminEditTestQuestionScreen.yesNo({
    super.key,
    required String question,
    required this.onSaveYesNo,
  })  : yesNoQuestion = question,
        onSaveMcq = null,
        this.question = null,
        isYesNo = true;

  @override
  State<AdminEditTestQuestionScreen> createState() =>
      _AdminEditTestQuestionScreenState();
}

class _AdminEditTestQuestionScreenState
    extends State<AdminEditTestQuestionScreen> {
  late TextEditingController _questionController;
  late TextEditingController _option1Controller;
  late TextEditingController _option2Controller;
  late TextEditingController _option3Controller;

  @override
  void initState() {
    super.initState();

    _questionController = TextEditingController(
      text: widget.isYesNo
          ? widget.yesNoQuestion ?? ''
          : widget.question?.question ?? '',
    );

    _option1Controller = TextEditingController(
      text: widget.question?.options.isNotEmpty == true
          ? widget.question!.options[0].text
          : '',
    );
    _option2Controller = TextEditingController(
      text: widget.question?.options.length == 3
          ? widget.question!.options[1].text
          : '',
    );
    _option3Controller = TextEditingController(
      text: widget.question?.options.length == 3
          ? widget.question!.options[2].text
          : '',
    );
  }

  void save() {
    if (widget.isYesNo) {
      widget.onSaveYesNo?.call(_questionController.text.trim());
    } else {
      final question = TestQuestionModel(
        question: _questionController.text.trim(),
        options: [
          TestOptionModel(text: _option1Controller.text.trim(), score: 1),
          TestOptionModel(text: _option2Controller.text.trim(), score: 2),
          TestOptionModel(text: _option3Controller.text.trim(), score: 3),
        ],
      );
      widget.onSaveMcq?.call(question);
    }

    Navigator.pop(context);
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
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isYesNo
            ? 'Ha/Yo‘q savolni tahrirlash'
            : 'Savolni tahrirlash'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        children: [
          TextField(
            controller: _questionController,
            maxLines: 3,
            decoration: inputDecoration(
              'Savol',
              Icons.help_outline_rounded,
            ),
          ),
          if (!widget.isYesNo) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _option1Controller,
              decoration: inputDecoration(
                '1-variant (1 ball)',
                Icons.looks_one_rounded,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _option2Controller,
              decoration: inputDecoration(
                '2-variant (2 ball)',
                Icons.looks_two_rounded,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _option3Controller,
              decoration: inputDecoration(
                '3-variant (3 ball)',
                Icons.looks_3_rounded,
              ),
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
    );
  }
}