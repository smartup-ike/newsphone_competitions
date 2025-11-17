import 'package:newsphone_competitions/data/models/contest_categories.dart';
import 'package:newsphone_competitions/data/models/image.dart';
import 'package:newsphone_competitions/data/models/shows.dart';

class Contest {
  final String id;
  final String name;
  final List<ImageModel>? images;
  final DateTime dateStart;
  final DateTime dateEnd;
  final ContestCategories? category;
  final bool? isActive;
  final String? instructions;
  final bool? isBigContest;
  final List<Shows> shows;

  Contest({
    required this.id,
    required this.name,
    this.images,
    required this.dateStart,
    required this.dateEnd,
    this.category,
    this.isActive,
    this.instructions,
    this.isBigContest,
    required this.shows,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['id'] as String,
      name: json['name'] as String,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      dateStart: DateTime.parse(json['dateStart'] as String),
      dateEnd: DateTime.parse(json['dateEnd'] as String),
      category:
          json['category'] != null
              ? ContestCategories.fromJson(
                json['category'] as Map<String, dynamic>,
              )
              : null,
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
      'imageUrl': images,
      'dateStart': dateStart.toIso8601String(),
      'dateEnd': dateEnd.toIso8601String(),
      'category': category,
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
    ContestCategories? category,
    bool? isActive,
    String? instructions,
    bool? isBigContest,
    List<Shows>? shows,
  }) {
    return Contest(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? images,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      instructions: instructions ?? this.instructions,
      isBigContest: isBigContest ?? this.isBigContest,
      shows: shows ?? this.shows,
    );
  }
}
