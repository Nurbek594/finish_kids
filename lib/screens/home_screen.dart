import 'package:flutter/material.dart';
import '../models/home_menu_model.dart';
import '../theme/app_theme.dart';
import '../widgets/home_menu_card.dart';
import 'gender_info_screen.dart';
import 'who_am_i_screen.dart';
import 'stories_screen.dart';
import 'parents_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _headerFade;
  late Animation<double> _headerSlide;
  late Animation<double> _bottomFade;

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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _headerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _headerSlide = Tween<double>(begin: 35, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _bottomFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 1, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openScreen(int index) {
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
    }
  }

  Widget _buildAnimatedCard(HomeMenuModel item, int index) {
    final start = 0.15 + (index * 0.12);
    final end = (start + 0.45).clamp(0.0, 1.0);

    final fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );

    final slide = Tween<double>(begin: 45, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: fade.value,
          child: Transform.translate(
            offset: Offset(0, slide.value),
            child: child,
          ),
        );
      },
      child: HomeMenuCard(
        item: item,
        onTap: () => _openScreen(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF9F6FF),
                  Color(0xFFF7FBFF),
                  Color(0xFFFFFAF2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Opacity(
                    opacity: _headerFade.value,
                    child: Transform.translate(
                      offset: Offset(0, _headerSlide.value),
                      child: Padding(
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
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: -10,
                                right: -5,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 76,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.18),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                          'Bolalar va ota-onalar uchun foydali, chiroyli va qiziqarli ilova',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Bo‘limlar',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Text(
                            '4 bo‘lim',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                      itemCount: menuItems.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.92,
                      ),
                      itemBuilder: (context, index) {
                        return _buildAnimatedCard(menuItems[index], index);
                      },
                    ),
                  ),
                  Opacity(
                    opacity: _bottomFade.value,
                    child: Transform.translate(
                      offset: Offset(0, _headerSlide.value * 0.7),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
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
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xFFF1EDFF),
                                child: Icon(
                                  Icons.lightbulb_rounded,
                                  color: AppTheme.primaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Maslahat: Har bir bo‘limni birma-bir to‘ldirib boramiz. Keyingi bosqichda ertaklarni ko‘paytirish yoki admin panelga o‘tish mumkin.',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    height: 1.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}