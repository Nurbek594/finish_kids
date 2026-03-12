import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  late TextEditingController contentController;

  late String selectedImagePath;
  late bool isLocalImage;
  bool isPickingImage = false;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.story.title);
    descriptionController =
        TextEditingController(text: widget.story.shortDescription);
    categoryController = TextEditingController(text: widget.story.category);
    readMinutesController =
        TextEditingController(text: widget.story.readMinutes.toString());
    contentController = TextEditingController(text: widget.story.content);
    selectedImagePath = widget.story.coverImage;
    isLocalImage = widget.story.isLocalImage;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    setState(() {
      isPickingImage = true;
    });

    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    setState(() {
      isPickingImage = false;
      if (file != null) {
        selectedImagePath = file.path;
        isLocalImage = true;
      }
    });
  }

  void save() {
    final editedStory = StoryModel(
      title: titleController.text.trim(),
      coverImage: selectedImagePath,
      shortDescription: descriptionController.text.trim(),
      category: categoryController.text.trim(),
      readMinutes: int.tryParse(readMinutesController.text.trim()) ?? 2,
      content: contentController.text.trim(),
      isLocalImage: isLocalImage,
    );

    widget.onSave(editedStory);
    Navigator.pop(context);
  }

  Widget buildImagePreview() {
    if (isPickingImage) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selectedImagePath.isEmpty) {
      return Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xFFF4F6FA),
        ),
        child: const Center(
          child: Icon(
            Icons.image_outlined,
            size: 54,
            color: AppTheme.primaryColor,
          ),
        ),
      );
    }

    if (isLocalImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.file(
          File(selectedImagePath),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 180,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        selectedImagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 180,
        errorBuilder: (_, __, ___) => Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xFFF4F6FA),
          ),
          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              size: 54,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
    );
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
    descriptionController.dispose();
    categoryController.dispose();
    readMinutesController.dispose();
    contentController.dispose();
    super.dispose();
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
          buildImagePreview(),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.photo_library_rounded),
              label: const Text('Galereyadan yangi rasm tanlash'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
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
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}