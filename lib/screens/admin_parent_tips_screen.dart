import 'dart:io';
import 'package:flutter/material.dart';
import '../data/parent_tips_data.dart';
import '../models/parent_tip_model.dart';
import '../services/parent_tip_storage_service.dart';
import '../theme/app_theme.dart';
import 'admin_add_parent_tip_screen.dart';
import 'admin_edit_parent_tip_screen.dart';

class AdminParentTipsScreen extends StatefulWidget {
  const AdminParentTipsScreen({super.key});

  @override
  State<AdminParentTipsScreen> createState() => _AdminParentTipsScreenState();
}

class _AdminParentTipsScreenState extends State<AdminParentTipsScreen> {
  List<ParentTipModel> tips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTips();
  }

  Future<void> _loadTips() async {
    final loaded = await ParentTipStorageService.loadTips();

    if (!mounted) return;

    setState(() {
      tips = loaded ?? List<ParentTipModel>.from(parentTips);
      isLoading = false;
    });
  }

  Future<void> _saveTips() async {
    await ParentTipStorageService.saveTips(tips);
  }

  Future<void> _resetData() async {
    await ParentTipStorageService.clearTips();

    if (!mounted) return;

    setState(() {
      tips = List<ParentTipModel>.from(parentTips);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rasmlar default holatga qaytdi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _addTip(ParentTipModel item) async {
    setState(() {
      tips.insert(0, item);
    });

    await _saveTips();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rasm qo‘shildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _editTip(int index, ParentTipModel updated) async {
    setState(() {
      tips[index] = updated;
    });

    await _saveTips();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rasm yangilandi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Future<void> _deleteItem(int index) async {
    setState(() {
      tips.removeAt(index);
    });

    await _saveTips();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rasm o‘chirildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
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
              Color(0xFFD9F4FF),
              Color(0xFFE9D5FF),
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
                Icons.family_restroom_rounded,
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
                    '${tips.length} ta rasm mavjud',
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

  Widget _buildPreview(ParentTipModel item) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: item.isLocalImage
            ? Image.file(
          File(item.image),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.image_rounded,
            color: AppTheme.primaryColor,
          ),
        )
            : Image.asset(
          item.image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.image_rounded,
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Ota-onalar rasmlar'),
        actions: [
          IconButton(
            onPressed: isLoading ? null : _resetData,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Defaultga qaytarish',
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
            child: tips.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: tips.length,
              itemBuilder: (context, index) {
                final item = tips[index];

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
                      _buildPreview(item),
                      const Spacer(),
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AdminEditParentTipScreen(
                                      tip: item,
                                      onSave: (updated) =>
                                          _editTip(index, updated),
                                    ),
                              ),
                            );
                          } else if (value == 'delete') {
                            await _deleteItem(index);
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
        onPressed: isLoading
            ? null
            : () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdminAddParentTipScreen(
                onAdd: _addTip,
              ),
            ),
          );
        },
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