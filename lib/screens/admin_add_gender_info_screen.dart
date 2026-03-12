import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _shortDescriptionController =
  TextEditingController();
  final TextEditingController _fullDescriptionController =
  TextEditingController();
  final TextEditingController _authorController = TextEditingController();

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

  void saveItem() {
    if (!_formKey.currentState!.validate()) return;

    final item = GenderInfoModel(
      title: _titleController.text.trim(),
      image: selectedImagePath.isEmpty
          ? 'assets/images/gender1.png'
          : selectedImagePath,
      shortDescription: _shortDescriptionController.text.trim(),
      fullDescription: _fullDescriptionController.text.trim(),
      author: _authorController.text.trim(),
      isLocalImage: selectedImagePath.isNotEmpty,
    );

    widget.onAdd(item);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
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
        title: const Text('Yangi gender info qo‘shish'),
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
                decoration:
                _inputDecoration('To‘liq ma’lumot', Icons.article_rounded),
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