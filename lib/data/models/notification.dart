import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 0)
class AppNotification extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String body;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  bool isRead;

  @HiveField(4)
  final String? competitionId;

  @HiveField(5)
  final DateTime? endDate;

  AppNotification({
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.competitionId,
    this.endDate,
  });
}
