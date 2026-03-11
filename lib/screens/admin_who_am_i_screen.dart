import 'package:flutter/material.dart';
import '../data/who_am_i_data.dart';
import '../models/who_am_i_item_model.dart';
import '../services/who_am_i_storage_service.dart';
import '../theme/app_theme.dart';

class AdminWhoAmIScreen extends StatefulWidget {
  const AdminWhoAmIScreen({super.key});

  @override
  State<AdminWhoAmIScreen> createState() => _AdminWhoAmIScreenState();
}

class _AdminWhoAmIScreenState extends State<AdminWhoAmIScreen> {
  List<WhoAmIItemModel> toys = [];
  List<WhoAmIItemModel> jobs = [];
  bool isLoading = true;
  int currentTab = 0; // 0 = toys, 1 = jobs

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedToys = await WhoAmIStorageService.loadToys();
    final loadedJobs = await WhoAmIStorageService.loadJobs();

    if (!mounted) return;

    setState(() {
      toys = loadedToys;
      jobs = loadedJobs;
      isLoading = false;
    });
  }

  List<WhoAmIItemModel> get currentList => currentTab == 0 ? toys : jobs;

  Future<void> _saveCurrentLists() async {
    await WhoAmIStorageService.saveToys(toys);
    await WhoAmIStorageService.saveJobs(jobs);
  }

  Future<void> _resetData() async {
    await WhoAmIStorageService.resetAll();

    if (!mounted) return;

    setState(() {
      toys = List<WhoAmIItemModel>.from(toyItems);
      jobs = List<WhoAmIItemModel>.from(jobItems);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Men kimman? ma’lumotlari default holatga qaytdi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _showAddDialog() {
    final titleController = TextEditingController();
    final imageController = TextEditingController(
      text: currentTab == 0
          ? 'assets/images/toy1.png'
          : 'assets/images/job1.png',
    );
    final categoryController = TextEditingController(
      text: currentTab == 0 ? 'toy' : 'job',
    );
    final scoreController = TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          currentTab == 0
              ? 'Yangi o‘yinchoq qo‘shish'
              : 'Yangi kasb qo‘shish',
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Nomi'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'Rasm yo‘li'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Kategoriya'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: scoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ball'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newItem = WhoAmIItemModel(
                title: titleController.text.trim(),
                image: imageController.text.trim(),
                category: categoryController.text.trim(),
                score: int.tryParse(scoreController.text.trim()) ?? 1,
              );

              if (newItem.title.isEmpty || newItem.image.isEmpty) {
                return;
              }

              setState(() {
                if (currentTab == 0) {
                  toys.insert(0, newItem);
                } else {
                  jobs.insert(0, newItem);
                }
              });

              await _saveCurrentLists();

              if (!mounted) return;
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${newItem.title} qo‘shildi'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppTheme.primaryColor,
                ),
              );
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog({
    required WhoAmIItemModel item,
    required int index,
  }) {
    final titleController = TextEditingController(text: item.title);
    final imageController = TextEditingController(text: item.image);
    final categoryController = TextEditingController(text: item.category);
    final scoreController = TextEditingController(text: item.score.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Elementni tahrirlash'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Nomi'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'Rasm yo‘li'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Kategoriya'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: scoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ball'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updated = WhoAmIItemModel(
                title: titleController.text.trim(),
                image: imageController.text.trim(),
                category: categoryController.text.trim(),
                score: int.tryParse(scoreController.text.trim()) ?? 1,
              );

              setState(() {
                if (currentTab == 0) {
                  toys[index] = updated;
                } else {
                  jobs[index] = updated;
                }
              });

              await _saveCurrentLists();

              if (!mounted) return;
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${updated.title} yangilandi'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppTheme.primaryColor,
                ),
              );
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteItem(int index) async {
    final item = currentList[index];

    setState(() {
      if (currentTab == 0) {
        toys.removeAt(index);
      } else {
        jobs.removeAt(index);
      }
    });

    await _saveCurrentLists();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} o‘chirildi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = currentList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Men kimman?'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: currentTab == 0
                      ? [
                    const Color(0xFFFF8A65),
                    const Color(0xFFFFC371),
                  ]
                      : [
                    const Color(0xFF5DA9FF),
                    const Color(0xFF8ED2FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: (currentTab == 0
                        ? const Color(0xFFFF8A65)
                        : const Color(0xFF5DA9FF))
                        .withOpacity(0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      currentTab == 0
                          ? Icons.toys_rounded
                          : Icons.work_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentTab == 0
                              ? 'O‘yinchoqlar boshqaruvi'
                              : 'Kasblar boshqaruvi',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${items.length} ta element mavjud',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('O‘yinchoqlar'),
                    selected: currentTab == 0,
                    onSelected: (_) {
                      setState(() => currentTab = 0);
                    },
                    selectedColor: const Color(0xFFFFE3D8),
                    labelStyle: TextStyle(
                      color: currentTab == 0
                          ? const Color(0xFFFF8A65)
                          : AppTheme.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Kasblar'),
                    selected: currentTab == 1,
                    onSelected: (_) {
                      setState(() => currentTab = 1);
                    },
                    selectedColor: const Color(0xFFDFF1FF),
                    labelStyle: TextStyle(
                      color: currentTab == 1
                          ? const Color(0xFF5DA9FF)
                          : AppTheme.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: items.isEmpty
                ? const Center(
              child: Text(
                'Elementlar mavjud emas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

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
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item.image,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const Icon(
                              Icons.image_not_supported_rounded,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Kategoriya: ${item.category}',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ball: ${item.score}',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.image,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
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
        label: Text(
          currentTab == 0 ? 'O‘yinchoq qo‘shish' : 'Kasb qo‘shish',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}