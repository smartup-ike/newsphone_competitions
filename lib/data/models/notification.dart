// In lib/models/notification.dart
class AppNotification {
  final String title;
  final String body;
  final DateTime timestamp;
  bool isRead;
  final String? competitionId; // New: ID of the competition
  final DateTime? endDate;      // New: End date of the competition

  AppNotification({
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.competitionId, // Initialize new fields
    this.endDate,       // Initialize new fields
  });
}
