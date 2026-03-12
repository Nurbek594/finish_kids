class StoryModel {
  final String title;
  final String coverImage;
  final String shortDescription;
  final String content;
  final String category;
  final int readMinutes;
  final bool isLocalImage;

  const StoryModel({
    required this.title,
    required this.coverImage,
    required this.shortDescription,
    required this.content,
    required this.category,
    required this.readMinutes,
    this.isLocalImage = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'coverImage': coverImage,
      'shortDescription': shortDescription,
      'content': content,
      'category': category,
      'readMinutes': readMinutes,
      'isLocalImage': isLocalImage,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      title: map['title'] ?? '',
      coverImage: map['coverImage'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '',
      readMinutes: map['readMinutes'] ?? 2,
      isLocalImage: map['isLocalImage'] ?? false,
    );
  }
}