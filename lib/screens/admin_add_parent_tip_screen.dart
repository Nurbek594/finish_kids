import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _shortDescriptionController =
  TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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

  void saveTip() {
    if (!_formKey.currentState!.validate()) return;

    final tip = ParentTipModel(
      title: _titleController.text.trim(),
      image: selectedImagePath.isEmpty
          ? 'assets/images/tip1.png'
          : selectedImagePath,
      shortDescription: _shortDescriptionController.text.trim(),
      description: _descriptionController.text.trim(),
      isLocalImage: selectedImagePath.isNotEmpty,
    );

    widget.onAdd(tip);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
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

  Widget buildImagePreview() {
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
        title: const Text('Yangi tavsiya qo‘shish'),
      ),
      body: Container(
        color: const Color(0xFFF8FAFF),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            children: [
              buildImagePreview(),
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