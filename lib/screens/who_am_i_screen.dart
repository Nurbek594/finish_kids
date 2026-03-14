import 'dart:io';
import 'package:flutter/material.dart';
import '../models/diagnostic_result_model.dart';
import '../models/who_am_i_item_model.dart';
import '../services/who_am_i_storage_service.dart';
import '../data/diagnostic_results_data.dart';
import '../theme/app_theme.dart';
import 'who_am_i_result_screen.dart';

class WhoAmIScreen extends StatefulWidget {
  const WhoAmIScreen({super.key});

  @override
  State<WhoAmIScreen> createState() => _WhoAmIScreenState();
}

class _WhoAmIScreenState extends State<WhoAmIScreen> {
  int currentStep = 0;

  final List<WhoAmIItemModel> selectedToys = [];
  final List<WhoAmIItemModel> selectedJobs = [];

  List<WhoAmIItemModel> toyItemsLocal = [];
  List<WhoAmIItemModel> jobItemsLocal = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final toys = await WhoAmIStorageService.loadToys();
    final jobs = await WhoAmIStorageService.loadJobs();

    if (!mounted) return;

    setState(() {
      toyItemsLocal = toys;
      jobItemsLocal = jobs;
      isLoading = false;
    });
  }

  List<WhoAmIItemModel> get currentItems =>
      currentStep == 0 ? toyItemsLocal : jobItemsLocal;

  String get stepTitle =>
      currentStep == 0 ? '1-bosqich: O‘yinchoqlar' : '2-bosqich: Kasblar';

  String get stepSubtitle => currentStep == 0
      ? 'Bolaga yoqqan o‘yinchoqlarni tanlang'
      : 'Endi bolaga yoqqan kasblarni tanlang';

  double get progressValue => currentStep == 0 ? 0.5 : 1.0;

  bool isSelected(WhoAmIItemModel item) {
    if (currentStep == 0) return selectedToys.contains(item);
    return selectedJobs.contains(item);
  }

  void toggleSelection(WhoAmIItemModel item) {
    setState(() {
      if (currentStep == 0) {
        if (selectedToys.contains(item)) {
          selectedToys.remove(item);
        } else {
          selectedToys.add(item);
        }
      } else {
        if (selectedJobs.contains(item)) {
          selectedJobs.remove(item);
        } else {
          selectedJobs.add(item);
        }
      }
    });
  }

  int calculateScore() {
    final allSelected = [...selectedToys, ...selectedJobs];
    int score = 0;

    for (final item in allSelected) {
      score += item.score;
    }

    return score;
  }

  DiagnosticResultModel getResult(int score) {
    return diagnosticResults.firstWhere(
          (result) => score >= result.minScore && score <= result.maxScore,
      orElse: () => diagnosticResults.last,
    );
  }

  void nextStepOrFinish() {
    if (currentStep == 0) {
      if (selectedToys.isEmpty) {
        showMessage('Kamida 1 ta o‘yinchoq tanlang');
        return;
      }

      setState(() {
        currentStep = 1;
      });
    } else {
      if (selectedJobs.isEmpty) {
        showMessage('Kamida 1 ta kasb tanlang');
        return;
      }

      final score = calculateScore();
      final result = getResult(score);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WhoAmIResultScreen(
            score: score,
            result: result,
            selectedToys: selectedToys,
            selectedJobs: selectedJobs,
          ),
        ),
      );
    }
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  List<String> get selectedTitles {
    if (currentStep == 0) {
      return selectedToys.map((e) => e.title).toList();
    }
    return selectedJobs.map((e) => e.title).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount =
    currentStep == 0 ? selectedToys.length : selectedJobs.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Men kimman?'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: currentStep == 0
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
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: (currentStep == 0
                        ? const Color(0xFFFF8A65)
                        : const Color(0xFF5DA9FF))
                        .withOpacity(0.20),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          currentStep == 0
                              ? Icons.toys_rounded
                              : Icons.work_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stepTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              stepSubtitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            minHeight: 8,
                            value: progressValue,
                            backgroundColor: Colors.white24,
                            valueColor:
                            const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${(progressValue * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _CompactProgressCard(
                    title: '1-bosqich',
                    subtitle: 'O‘yinchoqlar',
                    isActive: currentStep == 0,
                    isDone: selectedToys.isNotEmpty,
                    color: const Color(0xFFFF8A65),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CompactProgressCard(
                    title: '2-bosqich',
                    subtitle: 'Kasblar',
                    isActive: currentStep == 1,
                    isDone: selectedJobs.isNotEmpty,
                    color: const Color(0xFF5DA9FF),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tanlanganlar: $selectedCount ta',
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selectedTitles.isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 34,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: selectedTitles
                    .map(
                      (title) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EDFF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              itemCount: currentItems.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.93,
              ),
              itemBuilder: (context, index) {
                final item = currentItems[index];
                final selected = isSelected(item);

                return GestureDetector(
                  onTap: () => toggleSelection(item),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: selected
                            ? AppTheme.primaryColor
                            : Colors.transparent,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: selected
                              ? AppTheme.primaryColor.withOpacity(0.14)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: LinearGradient(
                                colors: selected
                                    ? [
                                  const Color(0xFFEDE9FF),
                                  const Color(0xFFF6F2FF),
                                ]
                                    : [
                                  const Color(0xFFFFF4EF),
                                  const Color(0xFFFFFBF7),
                                ],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: item.image.startsWith('/') ||
                                  item.image.contains(r':\')
                                  ? Image.file(
                                File(item.image),
                                fit: BoxFit.cover,
                                errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                    ) {
                                  return Center(
                                    child: Icon(
                                      currentStep == 0
                                          ? Icons.toys_rounded
                                          : Icons.work_outline_rounded,
                                      size: 46,
                                      color: selected
                                          ? AppTheme.primaryColor
                                          : Colors.orange,
                                    ),
                                  );
                                },
                              )
                                  : Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                                errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                    ) {
                                  return Center(
                                    child: Icon(
                                      currentStep == 0
                                          ? Icons.toys_rounded
                                          : Icons.work_outline_rounded,
                                      size: 46,
                                      color: selected
                                          ? AppTheme.primaryColor
                                          : Colors.orange,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(10, 0, 10, 12),
                          child: Column(
                            children: [
                              Text(
                                item.title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 6),
                              AnimatedContainer(
                                duration:
                                const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppTheme.primaryColor
                                      : const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  selected ? 'Tanlandi' : 'Tanlash',
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: nextStepOrFinish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  currentStep == 0
                      ? 'Keyingi bosqich'
                      : 'Natijani ko‘rish',
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isActive;
  final bool isDone;
  final Color color;

  const _CompactProgressCard({
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.isDone,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.10) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? color : Colors.grey.shade200,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: isDone ? color : Colors.grey.shade200,
            child: Icon(
              isDone ? Icons.check_rounded : Icons.circle_outlined,
              size: 14,
              color: isDone ? Colors.white : Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
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