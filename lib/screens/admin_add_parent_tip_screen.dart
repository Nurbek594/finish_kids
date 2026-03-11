import 'package:flutter/material.dart';
import '../models/parent_tip_model.dart';
import '../theme/app_theme.dart';

class AdminAddParentTipScreen extends StatefulWidget {
  final void Function(ParentTipModel tip) onAdd;

  const AdminAddParentTipScreen({
    super.key,
    required this.onAdd,
  });

  @override
  State<AdminAddParentTipScreen> createState() =>
      _AdminAddParentTipScreenState();
}

class _AdminAddParentTipScreenState extends State<AdminAddParentTipScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController(
    text: 'assets/images/tip1.png',
  );
  final TextEditingController _shortDescriptionController =
  TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void saveTip() {
    if (!_formKey.currentState!.validate()) return;

    final tip = ParentTipModel(
      title: _titleController.text.trim(),
      image: _imageController.text.trim(),
      shortDescription: _shortDescriptionController.text.trim(),
      description: _descriptionController.text.trim(),
    );

    widget.onAdd(tip);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageController.dispose();
    _shortDescriptionController.dispose();
    _descriptionController.dispose();
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
        title: const Text('Yangi tavsiya qo‘shish'),
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
                      Color(0xFF5DA9FF),
                      Color(0xFF8ED2FF),
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
                            'Yangi tavsiya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Tavsiya ma’lumotlarini kiriting va saqlang',
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
                decoration:
                _inputDecoration('Tavsiya nomi', Icons.title_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tavsiya nomini kiriting';
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
                decoration: _inputDecoration(
                  'Qisqa tavsif',
                  Icons.short_text_rounded,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Qisqa tavsif kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 8,
                decoration:
                _inputDecoration('To‘liq tavsiya', Icons.article_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'To‘liq tavsiya kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: saveTip,
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