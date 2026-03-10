import 'package:flutter/material.dart';
import '../models/home_menu_model.dart';
import '../theme/app_theme.dart';
import '../widgets/home_menu_card.dart';
import 'gender_info_screen.dart';
import 'who_am_i_screen.dart';
import 'stories_screen.dart';
import 'parents_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showComingSoon(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Text('$title bo‘limi keyingi bosqichda ulanadi'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<HomeMenuModel> menuItems = [
      HomeMenuModel(
        title: 'Gender identifikatsiya',
        subtitle: 'Olimlar fikri, faktlar va tushuntirishlar',
        icon: Icons.psychology_alt_rounded,
        color1: const Color(0xFF7C5CFF),
        color2: const Color(0xFFB26BFF),
      ),
      HomeMenuModel(
        title: 'Men kimman?',
        subtitle: 'Rasmlar tanlash va yakuniy diagnostik natija',
        icon: Icons.child_care_rounded,
        color1: const Color(0xFFFF8A65),
        color2: const Color(0xFFFFC371),
      ),
      HomeMenuModel(
        title: 'Ertaklar',
        subtitle: 'Muqovali ertaklar va ularni o‘qish bo‘limi',
        icon: Icons.menu_book_rounded,
        color1: const Color(0xFF28C2A0),
        color2: const Color(0xFF7EE8C8),
      ),
      HomeMenuModel(
        title: 'Ota-onalar uchun',
        subtitle: 'Tavsiyalar va testlar bo‘limi',
        icon: Icons.family_restroom_rounded,
        color1: const Color(0xFF5DA9FF),
        color2: const Color(0xFF8ED2FF),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6C63FF),
                      Color(0xFF9A8CFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.24),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bolalar Psixologiyasi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Bolalar va ota-onalar uchun foydali, qiziqarli va chiroyli ilova',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Bo‘limlar',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];

                  return HomeMenuCard(
                    item: item,
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GenderInfoScreen(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WhoAmIScreen(),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StoriesScreen(),
                          ),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ParentsScreen(),
                          ),
                        );
                      } else {
                        _showComingSoon(context, item.title);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}