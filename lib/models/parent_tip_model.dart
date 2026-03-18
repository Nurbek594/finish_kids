class ParentTipModel {
  final String image;
  final bool isLocalImage;

  const ParentTipModel({
    required this.image,
    this.isLocalImage = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'isLocalImage': isLocalImage,
    };
  }

  factory ParentTipModel.fromMap(Map<String, dynamic> map) {
    return ParentTipModel(
      image: map['image'] ?? '',
      isLocalImage: map['isLocalImage'] ?? false,
    );
  }
}