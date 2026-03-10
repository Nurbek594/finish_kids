class DiagnosticResultModel {
  final String level;
  final String title;
  final String description;
  final String scientificNote;
  final int minScore;
  final int maxScore;

  const DiagnosticResultModel({
    required this.level,
    required this.title,
    required this.description,
    required this.scientificNote,
    required this.minScore,
    required this.maxScore,
  });
}