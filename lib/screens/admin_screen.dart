import 'package:flutter/material.dart';
import '../data/gender_info_data.dart';
import '../data/parent_tests_data.dart';
import '../data/parent_tips_data.dart';
import '../data/stories_data.dart';
import '../data/who_am_i_data.dart';
import '../models/gender_info_model.dart';
import '../models/parent_tip_model.dart';
import '../models/story_model.dart';
import '../models/test_question_model.dart';
import '../models/who_am_i_item_model.dart';
import '../services/gender_info_storage_service.dart';
import '../services/parent_tip_storage_service.dart';
import '../services/story_storage_service.dart';
import '../services/test_storage_service.dart';
import '../services/who_am_i_storage_service.dart';
import '../theme/app_theme.dart';
import 'admin_gender_info_screen.dart';
import 'admin_parent_tips_screen.dart';
import 'admin_stories_screen.dart';
import 'admin_tests_screen.dart';
import 'admin_who_am_i_screen.dart';
import 'admin_settings_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool isLoading = true;

  int genderCount = 0;
  int whoAmICount = 0;
  int storiesCount = 0;
  int tipsCount = 0;
  int testsCount = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final List<GenderInfoModel>? savedGenderInfos =
    await GenderInfoStorageService.loadGenderInfos();

    final List<StoryModel>? savedStories =
    await StoryStorageService.loadStories();

    final List<ParentTipModel>? savedTips =
    await ParentTipStorageService.loadTips();

    final List<WhoAmIItemModel> savedToys =
    await WhoAmIStorageService.loadToys();

    final List<WhoAmIItemModel> savedJobs =
    await WhoAmIStorageService.loadJobs();

    final List<TestQuestionModel>? savedTest1 =
    await TestStorageService.loadMcqQuestions(1);

    final List<TestQuestionModel>? savedTest2 =
    await TestStorageService.loadMcqQuestions(2);

    final List<String>? savedTest3 =
    await TestStorageService.loadYesNoQuestions();

    if (!mounted) return;

    setState(() {
      genderCount = (savedGenderInfos ?? genderInfoList).length;
      storiesCount = (savedStories ?? storiesList).length;
      tipsCount = (savedTips ?? parentTips).length;
      whoAmICount = savedToys.length + savedJobs.length;
      testsCount = (savedTest1 ?? parentTest1Questions).length +
          (savedTest2 ?? parentTest2Questions).length +
          (savedTest3 ?? parentTest3Questions).length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<_AdminMenuItem> items = [
      _AdminMenuItem(
        title: 'Gender ma’lumotlari',
        subtitle: 'Gender info kartalari va ma’lumotlarini boshqarish',
        icon: Icons.psychology_alt_rounded,
        color1: const Color(0xFF7C5CFF),
        color2: const Color(0xFFB26BFF),
      ),
      _AdminMenuItem(
        title: 'Men kimman?',
        subtitle: 'O‘yinchoqlar va kasblar rasmlarini boshqarish',
        icon: Icons.child_care_rounded,
        color1: const Color(0xFFFF8A65),
        color2: const Color(0xFFFFC371),
      ),
      _AdminMenuItem(
        title: 'Ertaklar',
        subtitle: 'Ertaklar ro‘yxati, qo‘shish, tahrirlash va o‘chirish',
        icon: Icons.menu_book_rounded,
        color1: const Color(0xFF28C2A0),
        color2: const Color(0xFF7EE8C8),
      ),
      _AdminMenuItem(
        title: 'Ota-onalar',
        subtitle: 'Tavsiyalarni qo‘shish, tahrirlash va boshqarish',
        icon: Icons.family_restroom_rounded,
        color1: const Color(0xFF5DA9FF),
        color2: const Color(0xFF8ED2FF),
      ),
      _AdminMenuItem(
        title: 'Testlar',
        subtitle: '1-test, 2-test va 3-test savollarini boshqarish',
        icon: Icons.quiz_rounded,
        color1: const Color(0xFF6C63FF),
        color2: const Color(0xFF9A8CFF),
      ),
    ];

    final stats = [
      _StatItem(
        title: 'Gender',
        value: genderCount.toString(),
        icon: Icons.psychology_alt_rounded,
        color: const Color(0xFF7C5CFF),
      ),
      _StatItem(
        title: 'Men kimman',
        value: whoAmICount.toString(),
        icon: Icons.child_care_rounded,
        color: const Color(0xFFFF8A65),
      ),
      _StatItem(
        title: 'Ertaklar',
        value: storiesCount.toString(),
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF28C2A0),
      ),
      _StatItem(
        title: 'Tavsiyalar',
        value: tipsCount.toString(),
        icon: Icons.family_restroom_rounded,
        color: const Color(0xFF5DA9FF),
      ),
      _StatItem(
        title: 'Test savollari',
        value: testsCount.toString(),
        icon: Icons.quiz_rounded,
        color: const Color(0xFF6C63FF),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AdminSettingsScreen(),
                ),
              );
              await _loadStats();
            },
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8F6FF),
              Color(0xFFF7FBFF),
              Color(0xFFFFFBF5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _loadStats,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2D3142),
                      Color(0xFF4F5D75),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.admin_panel_settings_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Professional Admin Dashboard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Ilovadagi barcha asosiy bo‘limlarni shu yerdan boshqarasiz',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  height: 1.45,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Umumiy statistika',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: stats.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final stat = stats[index];
                    return Container(
                      width: 145,
                      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: stat.color.withOpacity(0.12),
                            child: Icon(
                              stat.icon,
                              color: stat.color,
                              size: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            stat.value,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stat.title,
                            style: TextStyle(
                              fontSize: 12.8,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Boshqaruv bo‘limlari',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const AdminGenderInfoScreen(),
                          ),
                        );
                      } else if (index == 1) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminWhoAmIScreen(),
                          ),
                        );
                      } else if (index == 2) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminStoriesScreen(),
                          ),
                        );
                      } else if (index == 3) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const AdminParentTipsScreen(),
                          ),
                        );
                      } else if (index == 4) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminTestsScreen(),
                          ),
                        );
                      }

                      await _loadStats();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [item.color1, item.color2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: item.color1.withOpacity(0.22),
                            blurRadius: 14,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -16,
                            top: -16,
                            child: Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.18),
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    item.icon,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.subtitle,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Maslahat: Avval kontentni admindan yangilang, keyin foydalanuvchi qismida natijani tekshirib chiqing.',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminMenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color1;
  final Color color2;

  _AdminMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.color2,
  });
}

class _StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}