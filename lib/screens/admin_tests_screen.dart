import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'admin_test_questions_screen.dart';

class AdminTestsScreen extends StatelessWidget {
  const AdminTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tests = [
      {
        'id': 1,
        'title': '1-test',
        'subtitle':
        'Farzandingizning gender identifikatsiyasini shakllantirishdagi tarbiya yondoshuvi',
        'color1': const Color(0xFF7C5CFF),
        'color2': const Color(0xFFB26BFF),
        'icon': Icons.psychology_alt_rounded,
      },
      {
        'id': 2,
        'title': '2-test',
        'subtitle': 'Oiladagi pedagogik xulq-atvoringiz uslubini aniqlang',
        'color1': const Color(0xFFFF8A65),
        'color2': const Color(0xFFFFC371),
        'icon': Icons.groups_rounded,
      },
      {
        'id': 3,
        'title': '3-test',
        'subtitle': 'Ha / Yo‘q formatidagi qisqa anketa-test',
        'color1': const Color(0xFF28C2A0),
        'color2': const Color(0xFF7EE8C8),
        'icon': Icons.fact_check_rounded,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Testlar'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          final item = tests[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AdminTestQuestionsScreen(
                    testType: item['id'] as int,
                    testTitle: item['title'] as String,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    item['color1'] as Color,
                    item['color2'] as Color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: (item['color1'] as Color).withOpacity(0.24),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['subtitle'] as String,
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
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 18,
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