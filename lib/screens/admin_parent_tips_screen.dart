import 'package:flutter/material.dart';
import '../data/parent_tips_data.dart';
import '../models/parent_tip_model.dart';
import '../theme/app_theme.dart';
import '../services/parent_tip_storage_service.dart';
import 'admin_add_parent_tip_screen.dart';
import 'admin_edit_parent_tip_screen.dart';

class AdminParentTipsScreen extends StatefulWidget {
  const AdminParentTipsScreen({super.key});

  @override
  State<AdminParentTipsScreen> createState() => _AdminParentTipsScreenState();
}

class _AdminParentTipsScreenState extends State<AdminParentTipsScreen> {
  List<ParentTipModel> localTips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTips();
  }

  Future<void> _loadTips() async {
    final savedTips = await ParentTipStorageService.loadTips();

    if (!mounted) return;

    setState(() {
      localTips = savedTips ?? List<ParentTipModel>.from(parentTips);
      isLoading = false;
    });
  }

  Future<void> _saveTips() async {
    await ParentTipStorageService.saveTips(localTips);
  }

  Future<void> addTip(ParentTipModel tip) async {
    setState(() {
      localTips.insert(0, tip);
    });

    await _saveTips();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tip.title} qo‘shildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Future<void> editTip(int index, ParentTipModel newTip) async {
    setState(() {
      localTips[index] = newTip;
    });

    await _saveTips();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${newTip.title} yangilandi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Future<void> deleteTip(int index) async {
    final deleted = localTips[index];

    setState(() {
      localTips.removeAt(index);
    });

    await _saveTips();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deleted.title} o‘chirildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Future<void> resetTips() async {
    setState(() {
      localTips = List<ParentTipModel>.from(parentTips);
    });

    await _saveTips();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tavsiyalar default holatga qaytarildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Ota-onalar tavsiyalari'),
        actions: [
          IconButton(
            onPressed: isLoading ? null : resetTips,
            icon: const Icon(Icons.refresh_rounded),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
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
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5DA9FF).withOpacity(0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
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
                          'Tavsiyalar boshqaruvi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${localTips.length} ta tavsiya mavjud',
                          style: const TextStyle(
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
          ),
          const SizedBox(height: 14),
          Expanded(
            child: localTips.isEmpty
                ? const Center(
              child: Text(
                'Tavsiyalar mavjud emas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: localTips.length,
              itemBuilder: (context, index) {
                final tip = localTips[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 95,
                        height: 95,
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFEAF3FF),
                              Color(0xFFF5FAFF),
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            tip.image,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.family_restroom_rounded,
                                  size: 38,
                                  color: Color(0xFF5DA9FF),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              0, 12, 8, 12),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                tip.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                tip.shortDescription,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.8,
                                  height: 1.4,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AdminEditParentTipScreen(
                                      tip: tip,
                                      onSave: (newTip) {
                                        editTip(index, newTip);
                                      },
                                    ),
                              ),
                            );
                          }

                          if (value == 'delete') {
                            await deleteTip(index);
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
                        icon: const Icon(
                          Icons.more_vert_rounded,
                          color: AppTheme.textDark,
                        ),
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
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdminAddParentTipScreen(
                onAdd: addTip,
              ),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Tavsiya qo‘shish',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}