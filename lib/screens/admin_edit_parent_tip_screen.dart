import 'package:flutter/material.dart';
import '../models/parent_tip_model.dart';
import '../theme/app_theme.dart';

class AdminEditParentTipScreen extends StatefulWidget {
  final ParentTipModel tip;
  final Function(ParentTipModel) onSave;

  const AdminEditParentTipScreen({
    super.key,
    required this.tip,
    required this.onSave,
  });

  @override
  State<AdminEditParentTipScreen> createState() =>
      _AdminEditParentTipScreenState();
}

class _AdminEditParentTipScreenState extends State<AdminEditParentTipScreen> {
  late TextEditingController titleController;
  late TextEditingController imageController;
  late TextEditingController shortDescriptionController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.tip.title);
    imageController = TextEditingController(text: widget.tip.image);
    shortDescriptionController =
        TextEditingController(text: widget.tip.shortDescription);
    descriptionController = TextEditingController(text: widget.tip.description);
  }

  void save() {
    final editedTip = ParentTipModel(
      title: titleController.text,
      image: imageController.text,
      shortDescription: shortDescriptionController.text,
      description: descriptionController.text,
    );

    widget.onSave(editedTip);
    Navigator.pop(context);
  }

  InputDecoration input(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    imageController.dispose();
    shortDescriptionController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tavsiyani tahrirlash"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: titleController,
            decoration: input("Tavsiya nomi"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: imageController,
            decoration: input("Rasm manzili"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: shortDescriptionController,
            decoration: input("Qisqa tavsif"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            maxLines: 8,
            decoration: input("To‘liq tavsiya"),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Saqlash",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}