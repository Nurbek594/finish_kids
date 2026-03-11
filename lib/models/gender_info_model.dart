class GenderInfoModel {
  final String title;
  final String image;
  final String shortDescription;
  final String fullDescription;
  final String author;

  const GenderInfoModel({
    required this.title,
    required this.image,
    required this.shortDescription,
    required this.fullDescription,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'author': author,
    };
  }

  factory GenderInfoModel.fromMap(Map<String, dynamic> map) {
    return GenderInfoModel(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      fullDescription: map['fullDescription'] ?? '',
      author: map['author'] ?? '',
    );
  }
}