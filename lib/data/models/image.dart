class ImageModel {
  final int id;
  final String imageUrl;

  ImageModel({required this.id, required this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  // Add this helper getter
  bool get isVideo {
    final videoExtensions = ['.mp4', '.mov', '.wmv', '.avi', '.m4v'];
    return videoExtensions.any((ext) => imageUrl.toLowerCase().endsWith(ext));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'imageUrl': imageUrl};
  }
}