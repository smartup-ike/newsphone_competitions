class ContestCategories {
  final int id;
  final String name;

  ContestCategories({required this.id, required this.name});

  factory ContestCategories.fromJson(Map<String, dynamic> json) {
    return ContestCategories(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  /// CopyWith method
  ContestCategories copyWith({int? id, String? name}) {
    return ContestCategories(id: id ?? this.id, name: name ?? this.name);
  }
}
