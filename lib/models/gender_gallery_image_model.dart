class GenderGalleryImageModel {
  final String imagePath;
  final String title;
  final String description;
  final bool isLocalImage;

  const GenderGalleryImageModel({
    required this.imagePath,
    required this.title,
    required this.description,
    this.isLocalImage = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'title': title,
      'description': description,
      'isLocalImage': isLocalImage,
    };
  }

  factory GenderGalleryImageModel.fromMap(Map<String, dynamic> map) {
    return GenderGalleryImageModel(
      imagePath: map['imagePath'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isLocalImage: map['isLocalImage'] ?? true,
    );
  }
}