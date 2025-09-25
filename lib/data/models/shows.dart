class Shows {
  final int id;
  final String name;
  final String prefix;

  Shows({required this.id, required this.name, required this.prefix,});

  factory Shows.fromJson(Map<String, dynamic> json) {
    return Shows(id: json['showId'] as int, name: json['name'] as String, prefix: json['messagePrefix'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  /// CopyWith method
  Shows copyWith({int? id, String? name, String? prefix}) {
    return Shows(id: id ?? this.id, name: name ?? this.name, prefix: prefix ?? this.prefix);
  }
}
