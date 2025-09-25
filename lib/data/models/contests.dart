import 'package:newsphone_competitions/data/models/shows.dart';

class Contest {
  final String id;
  final String name;
  final String? imageUrl;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String? contentsType;
  final bool? isActive;
  final String? instructions;
  final bool? isBigContest;
  final List<Shows> shows;

  Contest({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.dateStart,
    required this.dateEnd,
    this.contentsType,
    this.isActive,
    this.instructions,
    this.isBigContest,
    required this.shows,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      dateStart: DateTime.parse(json['dateStart'] as String),
      dateEnd: DateTime.parse(json['dateEnd'] as String),
      contentsType: json['contentsType'] as String?,
      isActive: json['is_active'] as bool?,
      instructions: json['instructions'] as String?,
      isBigContest: json['isBigContest'] as bool?,
      shows:
          (json['shows'] as List<dynamic>?)
              ?.map((e) => Shows.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
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
      'is_active': isActive,
      'instructions': instructions,
      'isBigContest': isBigContest,
      'shows': shows.map((e) => e.toJson()).toList(),
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
    bool? isActive,
    String? instructions,
    bool? isBigContest,
    List<Shows>? shows,
  }) {
    return Contest(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      contentsType: contentsType ?? this.contentsType,
      isActive: isActive ?? this.isActive,
      instructions: instructions ?? this.instructions,
      isBigContest: isBigContest ?? this.isBigContest,
      shows: shows ?? this.shows,
    );
  }
}
