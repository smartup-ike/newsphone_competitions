//const String defaultTopic = "14614Competitions";

enum ConsCategories { all, bigContests }

extension SpecialCategoryExtension on ConsCategories {
  String get name {
    switch (this) {
      case ConsCategories.all:
        return 'ΟΛΑ';
      case ConsCategories.bigContests:
        return 'Μεγάλοι Διαγωνισμοί';
    }
  }
}