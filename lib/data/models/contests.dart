class Contest {
  final String id;
  final String name;
  final String? imageUrl;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String? contentsType;

  Contest({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.dateStart,
    required this.dateEnd,
    this.contentsType,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      dateStart: DateTime.parse(json['dateStart'] as String),
      dateEnd: DateTime.parse(json['dateEnd'] as String),
      contentsType: json['contentsType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'dateStart': dateStart.toIso8601String(),
      'dateEnd': dateEnd.toIso8601String(),
      'contentsType': contentsType,
    };
  }

  /// CopyWith method
  Contest copyWith({
    String? id,
    String? name,
    String? imageUrl,
    DateTime? dateStart,
    DateTime? dateEnd,
    String? contentsType,
  }) {
    return Contest(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      contentsType: contentsType ?? this.contentsType,
    );
  }
}
