import 'dart:ui';

class Competition {
  final String title;
  final DateTime endDate;
  final Image img;
  final DateTime? callTime;
  final String? description;
  final String? prizeName;
  final int? phone;
  final String? msgInit;

  Competition(
    this.title,
    this.endDate,
    this.img,
    this.callTime,
    this.description,
    this.prizeName,
    this.phone,
    this.msgInit,
  );
}
