import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/parent_tip_model.dart';
import '../theme/app_theme.dart';

class AdminEditParentTipScreen extends StatefulWidget {
  final ParentTipModel tip;
  final void Function(ParentTipModel) onSave;

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
  late String selectedImagePath;
  late bool isLocalImage;
  bool isPickingImage = false;

  @override
  void initState() {
    super.initState();
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
    if (selectedImagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rasm tanlang'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final editedTip = ParentTipModel(
      image: selectedImagePath,
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
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: const Color(0xFFF4F6FA),
        ),
        child: const Center(
          child: Icon(
            Icons.image_outlined,
            size: 56,
            color: AppTheme.primaryColor,
          ),
        ),
      );
    }

    if (isLocalImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Image.file(
          File(selectedImagePath),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 260,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Image.asset(
        selectedImagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 260,
        errorBuilder: (_, __, ___) => Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color(0xFFF4F6FA),
          ),
          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              size: 56,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      appBar: AppBar(
        title: const Text('Rasmni tahrirlash'),
      ),
      body: ListView(
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
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Ota-onalar bo‘limidagi rasmni yangilash',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          buildImagePreview(),
          const SizedBox(height: 14),
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.photo_library_rounded),
              label: const Text('Yangi rasm tanlash'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: save,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}