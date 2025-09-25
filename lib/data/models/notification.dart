import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 0)
class AppNotification extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final String topicName;

  @HiveField(4)
  final DateTime sentAt;

  @HiveField(5)
  final int? linkedContestId;

  @HiveField(6)
  final int? linkedDealId;
  @HiveField(7)
  final String? type;
  @HiveField(8)
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.topicName,
    required this.sentAt,
    required this.type,
    this.linkedContestId,
    this.linkedDealId,
    this.isRead = false,
  });
}
