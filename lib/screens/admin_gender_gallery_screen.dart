import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/gender_gallery_image_model.dart';
import '../services/gender_gallery_storage_service.dart';
import '../theme/app_theme.dart';
import '../data/gender_gallery_default_data.dart';

class AdminGenderGalleryScreen extends StatefulWidget {
  const AdminGenderGalleryScreen({super.key});

  @override
  State<AdminGenderGalleryScreen> createState() =>
      _AdminGenderGalleryScreenState();
}

class _AdminGenderGalleryScreenState extends State<AdminGenderGalleryScreen> {
  List<GenderGalleryImageModel> images = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final saved = await GenderGalleryStorageService.loadImages();

    if (!mounted) return;

    setState(() {
      images = saved.isEmpty
          ? List<GenderGalleryImageModel>.from(defaultGenderGalleryImages)
          : saved;
      isLoading = false;
    });
  }

  Future<void> _saveImages() async {
    await GenderGalleryStorageService.saveImages(images);
  }

  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    return file?.path;
  }

  Widget _previewImage(String imagePath, {double size = 88}) {
    if (imagePath.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.image_outlined,
          color: AppTheme.primaryColor,
        ),
      );
    }

    final isLocal = imagePath.startsWith('/') || imagePath.contains(r':\');

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: isLocal
            ? Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.broken_image_outlined,
            color: AppTheme.primaryColor,
          ),
        )
            : Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.broken_image_outlined,
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }

  Future<void> _showAddDialog() async {
    String selectedImagePath = '';

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Yangi rasm qo‘shish'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _previewImage(selectedImagePath, size: 120),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final path = await _pickImage();
                          if (path != null) {
                            setDialogState(() {
                              selectedImagePath = path;
                            });
                          }
                        },
                        icon: const Icon(Icons.photo_library_rounded),
                        label: const Text('Rasm tanlash'),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Bekor qilish'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedImagePath.isEmpty) return;

                    final item = GenderGalleryImageModel(
                      imagePath: selectedImagePath,
                      title: '',
                      description: '',
                      isLocalImage: true,
                    );

                    setState(() {
                      images.insert(0, item);
                    });

                    await _saveImages();

                    if (!mounted) return;
                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Rasm qo‘shildi'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppTheme.primaryColor,
                      ),
                    );
                  },
                  child: const Text('Saqlash'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showEditDialog({
    required GenderGalleryImageModel item,
    required int index,
  }) async {
    String selectedImagePath = item.imagePath;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Rasmni tahrirlash'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _previewImage(selectedImagePath, size: 120),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final path = await _pickImage();
                          if (path != null) {
                            setDialogState(() {
                              selectedImagePath = path;
                            });
                          }
                        },
                        icon: const Icon(Icons.photo_library_rounded),
                        label: const Text('Yangi rasm tanlash'),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Bekor qilish'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedImagePath.isEmpty) return;

                    final updated = GenderGalleryImageModel(
                      imagePath: selectedImagePath,
                      title: '',
                      description: '',
                      isLocalImage: true,
                    );

                    setState(() {
                      images[index] = updated;
                    });

                    await _saveImages();

                    if (!mounted) return;
                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Rasm yangilandi'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppTheme.primaryColor,
                      ),
                    );
                  },
                  child: const Text('Saqlash'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteItem(int index) async {
    setState(() {
      images.removeAt(index);
    });

    await _saveImages();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rasm o‘chirildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> _clearAll() async {
    await GenderGalleryStorageService.clearImages();

    if (!mounted) return;

    setState(() {
      images = List<GenderGalleryImageModel>.from(defaultGenderGalleryImages);
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rasmlar default holatga qaytdi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFE9D5FF),
              Color(0xFFD9F4FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.photo_library_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rasmlar boshqaruvi',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${images.length} ta rasm mavjud',
                    style: const TextStyle(
                      color: AppTheme.textDark,
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
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'Rasmlar mavjud emas',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppTheme.textDark,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Gender rasmlar'),
        actions: [
          IconButton(
            onPressed: isLoading ? null : _clearAll,
            icon: const Icon(Icons.delete_sweep_rounded),
            tooltip: 'Barchasini tozalash',
          ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          const SizedBox(height: 8),
          _buildHeader(),
          const SizedBox(height: 14),
          Expanded(
            child: images.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final item = images[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _previewImage(item.imagePath, size: 96),
                      const Spacer(),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditDialog(
                              item: item,
                              index: index,
                            );
                          }
                          if (value == 'delete') {
                            _deleteItem(index);
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit_rounded),
                                SizedBox(width: 8),
                                Text('Tahrirlash'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 8),
                                Text('O‘chirish'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isLoading ? null : _showAddDialog,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Rasm qo‘shish',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}