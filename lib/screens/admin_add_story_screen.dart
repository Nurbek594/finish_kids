import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/story_model.dart';
import '../theme/app_theme.dart';

class AdminAddStoryScreen extends StatefulWidget {
  final void Function(StoryModel story) onAdd;

  const AdminAddStoryScreen({
    super.key,
    required this.onAdd,
  });

  @override
  State<AdminAddStoryScreen> createState() => _AdminAddStoryScreenState();
}

class _AdminAddStoryScreenState extends State<AdminAddStoryScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _shortDescriptionController =
  TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _readMinutesController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String selectedImagePath = '';
  bool isPickingImage = false;

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
      }
    });
  }

  void saveStory() {
    if (!_formKey.currentState!.validate()) return;

    final story = StoryModel(
      title: _titleController.text.trim(),
      coverImage: selectedImagePath.isEmpty
          ? 'assets/images/story1.png'
          : selectedImagePath,
      shortDescription: _shortDescriptionController.text.trim(),
      category: _categoryController.text.trim(),
      readMinutes: int.tryParse(_readMinutesController.text.trim()) ?? 2,
      content: _contentController.text.trim(),
      isLocalImage: selectedImagePath.isNotEmpty,
    );

    widget.onAdd(story);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _categoryController.dispose();
    _readMinutesController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
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

  Widget _buildImagePreview() {
    if (isPickingImage) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selectedImagePath.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yangi ertak qo‘shish'),
      ),
      body: Container(
        color: const Color(0xFFF8FAFF),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF28C2A0),
                      Color(0xFF7EE8C8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.add_box_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Yangi ertak qo‘shish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildImagePreview(),
              const SizedBox(height: 12),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: const Icon(Icons.photo_library_rounded),
                  label: const Text('Galereyadan rasm tanlash'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _titleController,
                decoration:
                _inputDecoration('Ertak nomi', Icons.title_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ertak nomini kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _shortDescriptionController,
                decoration: _inputDecoration(
                  'Qisqa tavsif',
                  Icons.short_text_rounded,
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Qisqa tavsif kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _categoryController,
                decoration:
                _inputDecoration('Kategoriya', Icons.category_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kategoriya kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _readMinutesController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  'O‘qish vaqti (daqiqada)',
                  Icons.schedule_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O‘qish vaqtini kiriting';
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return 'Raqam kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                maxLines: 10,
                decoration:
                _inputDecoration('Ertak matni', Icons.menu_book_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ertak matnini kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: saveStory,
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
      ),
    );
  }
}