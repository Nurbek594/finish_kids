import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/parent_tip_model.dart';
import '../theme/app_theme.dart';

class AdminEditParentTipScreen extends StatefulWidget {
  final ParentTipModel tip;
  final Function(ParentTipModel) onSave;

  const AdminEditParentTipScreen({
    super.key,
    required this.tip,
    required this.onSave,
  });

  @override
  State<AdminEditParentTipScreen> createState() =>
      _AdminEditParentTipScreenState();
}

class _AdminEditParentTipScreenState extends State<AdminEditParentTipScreen> {
  late TextEditingController titleController;
  late TextEditingController shortDescriptionController;
  late TextEditingController descriptionController;

  late String selectedImagePath;
  late bool isLocalImage;
  bool isPickingImage = false;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.tip.title);
    shortDescriptionController =
        TextEditingController(text: widget.tip.shortDescription);
    descriptionController = TextEditingController(text: widget.tip.description);
    selectedImagePath = widget.tip.image;
    isLocalImage = widget.tip.isLocalImage;
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
    final editedTip = ParentTipModel(
      title: titleController.text.trim(),
      image: selectedImagePath,
      shortDescription: shortDescriptionController.text.trim(),
      description: descriptionController.text.trim(),
      isLocalImage: isLocalImage,
    );

    widget.onSave(editedTip);
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
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tavsiyani tahrirlash"),
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
            decoration: input("Tavsiya nomi"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: shortDescriptionController,
            decoration: input("Qisqa tavsif"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            maxLines: 8,
            decoration: input("To‘liq tavsiya"),
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