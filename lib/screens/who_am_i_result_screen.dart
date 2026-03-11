import 'package:flutter/material.dart';
import '../models/diagnostic_result_model.dart';
import '../models/who_am_i_item_model.dart';
import '../theme/app_theme.dart';

class WhoAmIResultScreen extends StatelessWidget {
  final int score;
  final DiagnosticResultModel result;
  final List<WhoAmIItemModel> selectedToys;
  final List<WhoAmIItemModel> selectedJobs;

  const WhoAmIResultScreen({
    super.key,
    required this.score,
    required this.result,
    required this.selectedToys,
    required this.selectedJobs,
  });

  Color get resultColor {
    switch (result.level) {
      case 'low':
        return const Color(0xFFFF8A65);
      case 'medium':
        return const Color(0xFFFFC107);
      case 'high':
        return const Color(0xFF28C2A0);
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData get resultIcon {
    switch (result.level) {
      case 'low':
        return Icons.sentiment_neutral_rounded;
      case 'medium':
        return Icons.lightbulb_rounded;
      case 'high':
        return Icons.stars_rounded;
      default:
        return Icons.auto_awesome_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allTitles = [
      ...selectedToys.map((e) => e.title),
      ...selectedJobs.map((e) => e.title),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnostik natija'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    resultColor,
                    resultColor.withOpacity(0.70),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: resultColor.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      resultIcon,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    result.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Jami ball: $score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _InfoCard(
              title: 'Xulosa',
              child: Text(
                result.description,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 14),
            _InfoCard(
              title: 'Ilmiy eslatma',
              child: Text(
                result.scientificNote,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.7,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 14),
            _InfoCard(
              title: 'Tanlanganlar',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allTitles
                    .map(
                      (title) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EDFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFFFD778),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: Color(0xFFFFA000),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Eslatma: Ushbu natija klinik tashxis emas. U pedagogik-psixologik kuzatuv uchun yordamchi ko‘rsatkich sifatida taqdim etiladi.',
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
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text(
                  'Qayta boshlash',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: const BorderSide(
                    color: AppTheme.primaryColor,
                    width: 1.4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}