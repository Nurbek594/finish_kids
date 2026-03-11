import 'package:flutter/material.dart';
import '../data/gender_info_data.dart';
import '../models/gender_info_model.dart';
import '../theme/app_theme.dart';
import '../services/gender_info_storage_service.dart';
import 'admin_add_gender_info_screen.dart';
import 'admin_edit_gender_info_screen.dart';

class AdminGenderInfoScreen extends StatefulWidget {
  const AdminGenderInfoScreen({super.key});

  @override
  State<AdminGenderInfoScreen> createState() => _AdminGenderInfoScreenState();
}

class _AdminGenderInfoScreenState extends State<AdminGenderInfoScreen> {
  List<GenderInfoModel> localGenderInfos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGenderInfos();
  }

  Future<void> _loadGenderInfos() async {
    final savedItems = await GenderInfoStorageService.loadGenderInfos();

    if (!mounted) return;

    setState(() {
      localGenderInfos = savedItems ?? List<GenderInfoModel>.from(genderInfoList);
      isLoading = false;
    });
  }

  Future<void> _saveGenderInfos() async {
    await GenderInfoStorageService.saveGenderInfos(localGenderInfos);
  }

  Future<void> addGenderInfo(GenderInfoModel item) async {
    setState(() {
      localGenderInfos.insert(0, item);
    });

    await _saveGenderInfos();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} qo‘shildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Future<void> editGenderInfo(int index, GenderInfoModel newItem) async {
    setState(() {
      localGenderInfos[index] = newItem;
    });

    await _saveGenderInfos();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${newItem.title} yangilandi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Future<void> deleteGenderInfo(int index) async {
    final deleted = localGenderInfos[index];

    setState(() {
      localGenderInfos.removeAt(index);
    });

    await _saveGenderInfos();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deleted.title} o‘chirildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> resetGenderInfos() async {
    setState(() {
      localGenderInfos = List<GenderInfoModel>.from(genderInfoList);
    });

    await _saveGenderInfos();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gender info default holatga qaytarildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Gender ma’lumotlari'),
        actions: [
          IconButton(
            onPressed: isLoading ? null : resetGenderInfos,
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
                    Color(0xFF7C5CFF),
                    Color(0xFFB26BFF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C5CFF).withOpacity(0.22),
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
                      Icons.psychology_alt_rounded,
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
                          'Gender info boshqaruvi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${localGenderInfos.length} ta ma’lumot mavjud',
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
            child: localGenderInfos.isEmpty
                ? const Center(
              child: Text(
                'Ma’lumotlar mavjud emas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: localGenderInfos.length,
              itemBuilder: (context, index) {
                final item = localGenderInfos[index];

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
                              Color(0xFFEDE9FF),
                              Color(0xFFF8EEFF),
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            item.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.psychology_alt_rounded,
                                  size: 38,
                                  color: AppTheme.primaryColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 8, 12),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
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
                                item.shortDescription,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.8,
                                  height: 1.4,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1EDFF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item.author,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
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
                                builder: (_) => AdminEditGenderInfoScreen(
                                  item: item,
                                  onSave: (newItem) {
                                    editGenderInfo(index, newItem);
                                  },
                                ),
                              ),
                            );
                          }

                          if (value == 'delete') {
                            await deleteGenderInfo(index);
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
              builder: (_) => AdminAddGenderInfoScreen(
                onAdd: addGenderInfo,
              ),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Ma’lumot qo‘shish',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}