import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.72,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _textFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(
      begin: 40,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 3200), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, animation, __) => FadeTransition(
            opacity: animation,
            child: const HomeScreen(),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFloatingBubble({
    required double size,
    required double top,
    required double left,
    required Color color,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isSmallHeight = size.height < 700;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF9F4FF),
                  Color(0xFFEFF7FF),
                  Color(0xFFFFF8EE),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                _buildFloatingBubble(
                  size: 180,
                  top: -30,
                  left: -30,
                  color: const Color(0x337C5CFF),
                ),
                _buildFloatingBubble(
                  size: 140,
                  top: 120,
                  left: size.width - 120,
                  color: const Color(0x335DA9FF),
                ),
                _buildFloatingBubble(
                  size: 120,
                  top: size.height - 220,
                  left: 20,
                  color: const Color(0x33FFB84D),
                ),
                _buildFloatingBubble(
                  size: 200,
                  top: size.height - 170,
                  left: size.width - 170,
                  color: const Color(0x3328C2A0),
                ),
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 20,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: size.height * 0.75,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: Offset(0, _slideAnimation.value * -0.4),
                              child: Transform.scale(
                                scale: _logoScaleAnimation.value,
                                child: Container(
                                  width: isSmallHeight ? 145 : 170,
                                  height: isSmallHeight ? 145 : 170,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF7C5CFF),
                                        Color(0xFF9A8CFF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF7C5CFF,
                                        ).withOpacity(0.28),
                                        blurRadius: 28,
                                        offset: const Offset(0, 14),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: isSmallHeight ? 100 : 120,
                                        height: isSmallHeight ? 100 : 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.18),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Icon(
                                        Icons.psychology_alt_rounded,
                                        size: isSmallHeight ? 60 : 72,
                                        color: Colors.white,
                                      ),
                                      Positioned(
                                        bottom: isSmallHeight ? 18 : 22,
                                        right: isSmallHeight ? 24 : 28,
                                        child: Container(
                                          width: isSmallHeight ? 30 : 36,
                                          height: isSmallHeight ? 30 : 36,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFC371),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(
                                                  0xFFFFC371,
                                                ).withOpacity(0.35),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.favorite_rounded,
                                            size: isSmallHeight ? 16 : 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: isSmallHeight ? 22 : 34),
                            Opacity(
                              opacity: _textFadeAnimation.value,
                              child: Transform.translate(
                                offset: Offset(0, _slideAnimation.value),
                                child: Column(
                                  children: [
                                    Text(
                                      'Bolalar Psixologiyasi',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: isSmallHeight ? 25 : 30,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF2D3142),
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    SizedBox(height: isSmallHeight ? 8 : 12),
                                    Text(
                                      'Bolalar va ota-onalar uchun\nmehrli va foydali ilova',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: isSmallHeight ? 14 : 15.5,
                                        fontWeight: FontWeight.w600,
                                        height: 1.6,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    SizedBox(height: isSmallHeight ? 18 : 28),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.black.withOpacity(0.04),
                                            blurRadius: 12,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.4,
                                              valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Color(0xFF7C5CFF),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Yuklanmoqda...',
                                            style: TextStyle(
                                              fontSize: isSmallHeight ? 12.8 : 13.5,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
          );
        },
      ),
    );
  }
}