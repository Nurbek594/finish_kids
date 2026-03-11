import 'package:flutter/material.dart';
import '../models/gender_info_model.dart';
import '../theme/app_theme.dart';

class AdminAddGenderInfoScreen extends StatefulWidget {
  final void Function(GenderInfoModel item) onAdd;

  const AdminAddGenderInfoScreen({
    super.key,
    required this.onAdd,
  });

  @override
  State<AdminAddGenderInfoScreen> createState() =>
      _AdminAddGenderInfoScreenState();
}

class _AdminAddGenderInfoScreenState extends State<AdminAddGenderInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController(
    text: 'assets/images/gender1.png',
  );
  final TextEditingController _shortDescriptionController =
  TextEditingController();
  final TextEditingController _fullDescriptionController =
  TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void saveItem() {
    if (!_formKey.currentState!.validate()) return;

    final item = GenderInfoModel(
      title: _titleController.text.trim(),
      image: _imageController.text.trim(),
      shortDescription: _shortDescriptionController.text.trim(),
      fullDescription: _fullDescriptionController.text.trim(),
      author: _authorController.text.trim(),
    );

    widget.onAdd(item);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _authorController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yangi gender info qo‘shish'),
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
                      Color(0xFF7C5CFF),
                      Color(0xFFB26BFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.add_comment_rounded,
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
                            'Yangi ma’lumot',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Gender info ma’lumotlarini kiriting va saqlang',
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
                decoration: _inputDecoration('Sarlavha', Icons.title_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Sarlavhani kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageController,
                decoration:
                _inputDecoration('Rasm manzili', Icons.image_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Rasm manzilini kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _shortDescriptionController,
                maxLines: 2,
                decoration:
                _inputDecoration('Qisqa izoh', Icons.short_text_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Qisqa izoh kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _fullDescriptionController,
                maxLines: 8,
                decoration: _inputDecoration(
                  'To‘liq ma’lumot',
                  Icons.article_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'To‘liq ma’lumot kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _authorController,
                decoration:
                _inputDecoration('Muallif / manba', Icons.person_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Muallif yoki manba kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: saveItem,
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