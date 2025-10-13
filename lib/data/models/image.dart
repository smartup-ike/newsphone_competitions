class ImageModel {
  final int id;
  final String imageUrl;

  ImageModel({required this.id, required this.imageUrl});

  // Optional: create from JSON
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'imageUrl': imageUrl};
  }
}
