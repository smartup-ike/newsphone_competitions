class Category {
  final String title;   // Display name
  final String topicId; // Topic ID used for Firebase subscription

  Category({
    required this.title,
    required this.topicId,
  });
}