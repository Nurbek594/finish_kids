class StoryModel {
  final String title;
  final String coverImage;
  final String shortDescription;
  final String content;
  final String category;
  final int readMinutes;

  const StoryModel({
    required this.title,
    required this.coverImage,
    required this.shortDescription,
    required this.content,
    required this.category,
    required this.readMinutes,
  });
}