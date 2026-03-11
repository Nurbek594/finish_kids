import 'package:flutter/material.dart';
import '../models/gender_info_model.dart';
import '../theme/app_theme.dart';

class AdminEditGenderInfoScreen extends StatefulWidget {
  final GenderInfoModel item;
  final Function(GenderInfoModel) onSave;

  const AdminEditGenderInfoScreen({
    super.key,
    required this.item,
    required this.onSave,
  });

  @override
  State<AdminEditGenderInfoScreen> createState() =>
      _AdminEditGenderInfoScreenState();
}

class _AdminEditGenderInfoScreenState extends State<AdminEditGenderInfoScreen> {
  late TextEditingController titleController;
  late TextEditingController imageController;
  late TextEditingController shortDescriptionController;
  late TextEditingController fullDescriptionController;
  late TextEditingController authorController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.item.title);
    imageController = TextEditingController(text: widget.item.image);
    shortDescriptionController =
        TextEditingController(text: widget.item.shortDescription);
    fullDescriptionController =
        TextEditingController(text: widget.item.fullDescription);
    authorController = TextEditingController(text: widget.item.author);
  }

  void save() {
    final editedItem = GenderInfoModel(
      title: titleController.text,
      image: imageController.text,
      shortDescription: shortDescriptionController.text,
      fullDescription: fullDescriptionController.text,
      author: authorController.text,
    );

    widget.onSave(editedItem);
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
    fullDescriptionController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gender info tahrirlash"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: titleController,
            decoration: input("Sarlavha"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: imageController,
            decoration: input("Rasm manzili"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: shortDescriptionController,
            decoration: input("Qisqa izoh"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: fullDescriptionController,
            maxLines: 8,
            decoration: input("To‘liq ma’lumot"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: authorController,
            decoration: input("Muallif / manba"),
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