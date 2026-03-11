import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'admin_gender_info_screen.dart';
import 'admin_who_am_i_screen.dart';
import 'admin_stories_screen.dart';
import 'admin_parent_tips_screen.dart';
import 'admin_tests_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
      ),
      body: Column(
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
                    Color(0xFF2D3142),
                    Color(0xFF4F5D75),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.admin_panel_settings_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Boshqaruv bo‘limi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Ilovadagi asosiy kontent va bo‘limlarni shu yerdan boshqarasiz',
                          style: TextStyle(
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
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.92,
              ),
              itemBuilder: (context, index) {
                final item = items[index];

                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminGenderInfoScreen(),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminWhoAmIScreen(),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminStoriesScreen(),
                        ),
                      );
                    } else if (index == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminParentTipsScreen(),
                        ),
                      );
                    } else if (index == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminTestsScreen(),
                        ),
                      );
                    }
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(16),
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppTheme.primaryColor,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Bu yerda kiritilgan o‘zgarishlar ilovaning foydalanuvchi qismida ham ko‘rinadi.',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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