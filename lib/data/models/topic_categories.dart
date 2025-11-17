class TopicCategory {
  final String title;   // Display name
  final String topicId; // Topic ID used for Firebase subscription

  TopicCategory({
    required this.title,
    required this.topicId,
  });
}