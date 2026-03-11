import 'package:flutter/material.dart';
import '../data/who_am_i_data.dart';
import '../models/diagnostic_result_model.dart';
import '../models/who_am_i_item_model.dart';
import '../services/who_am_i_storage_service.dart';
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
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
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: (currentStep == 0
                        ? const Color(0xFFFF8A65)
                        : const Color(0xFF5DA9FF))
                        .withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          currentStep == 0
                              ? Icons.toys_rounded
                              : Icons.work_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stepTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              stepSubtitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            value: progressValue,
                            backgroundColor: Colors.white24,
                            valueColor:
                            const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${(progressValue * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _ProgressCard(
                    title: '1-bosqich',
                    subtitle: 'O‘yinchoqlar',
                    isActive: currentStep == 0,
                    isDone: selectedToys.isNotEmpty,
                    color: const Color(0xFFFF8A65),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ProgressCard(
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
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tanlanganlar: $selectedCount ta',
                      style: const TextStyle(
                        fontSize: 15,
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
            const SizedBox(height: 10),
            SizedBox(
              height: 42,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: selectedTitles
                    .map(
                      (title) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
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
          ],
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
              itemCount: currentItems.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.84,
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
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: selected
                            ? AppTheme.primaryColor
                            : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: selected
                              ? AppTheme.primaryColor.withOpacity(0.16)
                              : Colors.black.withOpacity(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      currentStep == 0
                                          ? Icons.toys_rounded
                                          : Icons.work_outline_rounded,
                                      size: 52,
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
                          const EdgeInsets.fromLTRB(12, 0, 12, 14),
                          child: Column(
                            children: [
                              Text(
                                item.title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 8),
                              AnimatedContainer(
                                duration:
                                const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppTheme.primaryColor
                                      : const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  selected ? 'Tanlandi' : 'Tanlash',
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                    fontSize: 12,
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: nextStepOrFinish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  currentStep == 0
                      ? 'Keyingi bosqich'
                      : 'Natijani ko‘rish',
                  style: const TextStyle(
                    fontSize: 17,
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

class _ProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isActive;
  final bool isDone;
  final Color color;

  const _ProgressCard({
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.12) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isActive ? color : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: isDone ? color : Colors.grey.shade200,
            child: Icon(
              isDone ? Icons.check_rounded : Icons.circle_outlined,
              size: 18,
              color: isDone ? Colors.white : Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
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