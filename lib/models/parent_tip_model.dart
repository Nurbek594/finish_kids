class ParentTipModel {
  final String title;
  final String image;
  final String shortDescription;
  final String description;
  final bool isLocalImage;

  const ParentTipModel({
    required this.title,
    required this.image,
    required this.shortDescription,
    required this.description,
    this.isLocalImage = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'shortDescription': shortDescription,
      'description': description,
      'isLocalImage': isLocalImage,
    };
  }

  factory ParentTipModel.fromMap(Map<String, dynamic> map) {
    return ParentTipModel(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      description: map['description'] ?? '',
      isLocalImage: map['isLocalImage'] ?? false,
    );
  }
}