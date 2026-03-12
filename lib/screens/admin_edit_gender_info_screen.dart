import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  late TextEditingController shortDescriptionController;
  late TextEditingController fullDescriptionController;
  late TextEditingController authorController;

  late String selectedImagePath;
  late bool isLocalImage;
  bool isPickingImage = false;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.item.title);
    shortDescriptionController =
        TextEditingController(text: widget.item.shortDescription);
    fullDescriptionController =
        TextEditingController(text: widget.item.fullDescription);
    authorController = TextEditingController(text: widget.item.author);
    selectedImagePath = widget.item.image;
    isLocalImage = widget.item.isLocalImage;
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
    final editedItem = GenderInfoModel(
      title: titleController.text.trim(),
      image: selectedImagePath,
      shortDescription: shortDescriptionController.text.trim(),
      fullDescription: fullDescriptionController.text.trim(),
      author: authorController.text.trim(),
      isLocalImage: isLocalImage,
    );

    widget.onSave(editedItem);
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
            decoration: input("Sarlavha"),
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