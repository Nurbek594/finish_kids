class ParentTipModel {
  final String title;
  final String image;
  final String shortDescription;
  final String description;

  const ParentTipModel({
    required this.title,
    required this.image,
    required this.shortDescription,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'shortDescription': shortDescription,
      'description': description,
    };
  }

  factory ParentTipModel.fromMap(Map<String, dynamic> map) {
    return ParentTipModel(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      description: map['description'] ?? '',
    );
  }
}