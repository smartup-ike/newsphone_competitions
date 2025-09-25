class Topic {
  final int id;
  final String name;
  final String description;

  Topic({
    required this.id,
    required this.name,
    required this.description,
  });

  // Factory constructor to create a Topic from JSON
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  // Convert Topic to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
