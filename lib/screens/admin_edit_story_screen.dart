import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../theme/app_theme.dart';

class AdminEditStoryScreen extends StatefulWidget {
  final StoryModel story;
  final Function(StoryModel) onSave;

  const AdminEditStoryScreen({
    super.key,
    required this.story,
    required this.onSave,
  });

  @override
  State<AdminEditStoryScreen> createState() => _AdminEditStoryScreenState();
}

class _AdminEditStoryScreenState extends State<AdminEditStoryScreen> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController readMinutesController;
  late TextEditingController imageController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.story.title);

    descriptionController =
        TextEditingController(text: widget.story.shortDescription);

    categoryController =
        TextEditingController(text: widget.story.category);

    readMinutesController =
        TextEditingController(text: widget.story.readMinutes.toString());

    imageController =
        TextEditingController(text: widget.story.coverImage);

    contentController =
        TextEditingController(text: widget.story.content);
  }

  void save() {

    final editedStory = StoryModel(
      title: titleController.text,
      coverImage: imageController.text,
      shortDescription: descriptionController.text,
      category: categoryController.text,
      readMinutes: int.tryParse(readMinutesController.text) ?? 2,
      content: contentController.text,
    );

    widget.onSave(editedStory);

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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ertakni tahrirlash"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          TextField(
            controller: titleController,
            decoration: input("Ertak nomi"),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: descriptionController,
            decoration: input("Qisqa tavsif"),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: categoryController,
            decoration: input("Kategoriya"),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: readMinutesController,
            keyboardType: TextInputType.number,
            decoration: input("O‘qish vaqti"),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: imageController,
            decoration: input("Rasm manzili"),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: contentController,
            maxLines: 8,
            decoration: input("Ertak matni"),
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