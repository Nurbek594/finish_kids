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

  Color getColor() {
    if (result.level == 'low') {
      return Colors.orange;
    }
    if (result.level == 'medium') {
      return Colors.blue;
    }
    return Colors.green;
  }

  IconData getIcon() {
    if (result.level == 'low') {
      return Icons.sentiment_dissatisfied_rounded;
    }
    if (result.level == 'medium') {
      return Icons.sentiment_neutral_rounded;
    }
    return Icons.sentiment_very_satisfied_rounded;
  }

  Widget _buildSelectedSection({
    required String title,
    required List<WhoAmIItemModel> items,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(
                  title.contains('O‘yinchoq')
                      ? Icons.toys_rounded
                      : Icons.work_rounded,
                  color: color,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (items.isEmpty)
            Text(
              'Tanlanmagan',
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w700,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items
                  .map(
                    (item) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      appBar: AppBar(
        title: const Text("Diagnostik natija"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.65),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Icon(
                  getIcon(),
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  result.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ball: $score',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              result.scientificNote,
              style: const TextStyle(
                fontSize: 14,
                height: 1.55,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
          ),
          const SizedBox(height: 14),
          _buildSelectedSection(
            title: 'Tanlangan o‘yinchoqlar',
            items: selectedToys,
            color: const Color(0xFFFF8A65),
          ),
          const SizedBox(height: 14),
          _buildSelectedSection(
            title: 'Tanlangan kasblar',
            items: selectedJobs,
            color: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }
}