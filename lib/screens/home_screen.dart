import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'admin_login_screen.dart';
import 'gender_info_screen.dart';
import 'parents_screen.dart';
import 'stories_screen.dart';
import 'who_am_i_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _bgController;
  late final AnimationController _cardController;

  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<_HomeMenuItem> items = [
      _HomeMenuItem(
        title: 'Gender identifikatsiya nima?',
        subtitle: 'Foydali ma’lumotlar va izohlar',
        icon: Icons.psychology_alt_rounded,
        color1: const Color(0xFF8B5CF6),
        color2: const Color(0xFFC084FC),
        screen: const GenderInfoScreen(),
      ),
      _HomeMenuItem(
        title: 'Men kimman?',
        subtitle: 'Rasmlar orqali qiziq tanlov',
        icon: Icons.child_care_rounded,
        color1: const Color(0xFFFF8A65),
        color2: const Color(0xFFFFC371),
        screen: const WhoAmIScreen(),
      ),
      _HomeMenuItem(
        title: 'Ertaklar',
        subtitle: 'Qiziqarli va tarbiyaviy hikoyalar',
        icon: Icons.menu_book_rounded,
        color1: const Color(0xFF22C55E),
        color2: const Color(0xFF86EFAC),
        screen: const StoriesScreen(),
      ),
      _HomeMenuItem(
        title: 'Ota-onalar uchun',
        subtitle: 'Tavsiyalar va testlar',
        icon: Icons.family_restroom_rounded,
        color1: const Color(0xFF3B82F6),
        color2: const Color(0xFF93C5FD),
        screen: const ParentsScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminLoginScreen(),
            ),
          );
        },
        icon: const Icon(Icons.admin_panel_settings_rounded),
        label: const Text(
          'Admin',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              final value = _bgController.value;

              return Stack(
                children: [
                  Positioned(
                    top: 30 + (value * 20),
                    left: -20 + (value * 15),
                    child: _FloatingBubble(
                      size: 110,
                      color: const Color(0xFFFFD6E7).withOpacity(0.55),
                    ),
                  ),
                  Positioned(
                    top: 130 - (value * 18),
                    right: -10,
                    child: _FloatingBubble(
                      size: 95,
                      color: const Color(0xFFD9F4FF).withOpacity(0.65),
                    ),
                  ),
                  Positioned(
                    bottom: 130 + (value * 16),
                    left: -25,
                    child: _FloatingBubble(
                      size: 120,
                      color: const Color(0xFFFFF0C9).withOpacity(0.55),
                    ),
                  ),
                  Positioned(
                    bottom: 40 - (value * 12),
                    right: 10,
                    child: Transform.rotate(
                      angle: value * 0.3,
                      child: _FloatingBubble(
                        size: 85,
                        color: const Color(0xFFE9D5FF).withOpacity(0.45),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              children: [
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _cardController,
                    curve: Curves.easeOut,
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.06),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _cardController,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFD6E7),
                            Color(0xFFD9F4FF),
                            Color(0xFFFFF0C9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.10),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/images/kids_banner.png',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.sentiment_very_satisfied_rounded,
                                        size: 56,
                                        color: Color(0xFFFF8A65),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Banner rasmi topilmadi',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Bolalar psixologiyasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Qiziqarli bo‘limlar, ertaklar va foydali tavsiyalar bilan bolalar uchun quvnoq ilova',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _MiniInfoCard(
                        icon: Icons.favorite_rounded,
                        title: 'Mehribon',
                        subtitle: 'Bolalarga mos',
                        color: const Color(0xFFFF8FA3),
                        delay: 0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _MiniInfoCard(
                        icon: Icons.auto_stories_rounded,
                        title: 'Qiziqarli',
                        subtitle: 'Ertaklar va o‘yin',
                        color: const Color(0xFF34D399),
                        delay: 120,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _MiniInfoCard(
                        icon: Icons.lightbulb_rounded,
                        title: 'Foydali',
                        subtitle: 'Tavsiyalar',
                        color: const Color(0xFF60A5FA),
                        delay: 240,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bo‘limlar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.92,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _BounceMenuCard(
                      delay: index * 110,
                      item: item,
                    );
                  },
                ),
                const SizedBox(height: 18),
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _cardController,
                    curve: const Interval(0.4, 1, curve: Curves.easeOut),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFB703),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Bolaga ilova bilan ishlashda erkinlik bering va bo‘limlarni birgalikda sinab ko‘ring.',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BounceMenuCard extends StatefulWidget {
  final _HomeMenuItem item;
  final int delay;

  const _BounceMenuCard({
    required this.item,
    required this.delay,
  });

  @override
  State<_BounceMenuCard> createState() => _BounceMenuCardState();
}

class _BounceMenuCardState extends State<_BounceMenuCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 650 + widget.delay),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => widget.item.screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appearAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    return FadeTransition(
      opacity: appearAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(appearAnimation),
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              _pressed = true;
            });
          },
          onTapCancel: () {
            setState(() {
              _pressed = false;
            });
          },
          onTapUp: (_) {
            setState(() {
              _pressed = false;
            });
            _openScreen();
          },
          child: AnimatedScale(
            scale: _pressed ? 0.96 : 1,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: AnimatedRotation(
              turns: _pressed ? -0.01 : 0,
              duration: const Duration(milliseconds: 120),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.item.color1, widget.item.color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: widget.item.color1.withOpacity(0.22),
                      blurRadius: 14,
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
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.14),
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
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              widget.item.icon,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.item.subtitle,
                            maxLines: 2,
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
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeMenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color1;
  final Color color2;
  final Widget screen;

  _HomeMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.screen,
  });
}

class _MiniInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final int delay;

  const _MiniInfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.delay,
  });

  @override
  State<_MiniInfoCard> createState() => _MiniInfoCardState();
}

class _MiniInfoCardState extends State<_MiniInfoCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600 + widget.delay),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(animation),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1),
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: widget.color.withOpacity(0.14),
                      child: Icon(
                        widget.icon,
                        color: widget.color,
                        size: 18,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingBubble extends StatelessWidget {
  final double size;
  final Color color;

  const _FloatingBubble({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 10,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2.6),
        ),
      ),
    );
  }
}