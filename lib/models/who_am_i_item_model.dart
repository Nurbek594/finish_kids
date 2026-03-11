class WhoAmIItemModel {
  final String title;
  final String image;
  final String category;
  final int score;

  const WhoAmIItemModel({
    required this.title,
    required this.image,
    required this.category,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'category': category,
      'score': score,
    };
  }

  factory WhoAmIItemModel.fromMap(Map<String, dynamic> map) {
    return WhoAmIItemModel(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      score: map['score'] ?? 1,
    );
  }
}