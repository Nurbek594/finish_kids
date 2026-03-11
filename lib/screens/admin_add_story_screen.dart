import 'package:flutter/material.dart';
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
  final TextEditingController _coverImageController = TextEditingController(
    text: 'assets/images/story1.png',
  );

  void saveStory() {
    if (!_formKey.currentState!.validate()) return;

    final story = StoryModel(
      title: _titleController.text.trim(),
      coverImage: _coverImageController.text.trim(),
      shortDescription: _shortDescriptionController.text.trim(),
      category: _categoryController.text.trim(),
      readMinutes: int.tryParse(_readMinutesController.text.trim()) ?? 2,
      content: _contentController.text.trim(),
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
    _coverImageController.dispose();
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.2,
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF28C2A0).withOpacity(0.22),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yangi ertak',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Ertak ma’lumotlarini kiriting va saqlang',
                            style: TextStyle(
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration(
                  'Ertak nomi',
                  Icons.title_rounded,
                ),
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
                decoration: _inputDecoration(
                  'Kategoriya',
                  Icons.category_rounded,
                ),
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
                controller: _coverImageController,
                decoration: _inputDecoration(
                  'Rasm manzili',
                  Icons.image_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Rasm manzilini kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                maxLines: 10,
                decoration: _inputDecoration(
                  'Ertak matni',
                  Icons.menu_book_rounded,
                ),
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