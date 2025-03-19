enum CompetitionType { vehicle, phone, money, shopping, trip }

class Competition {
  final String title;
  final DateTime endDate;
  final String imgPath;
  final CompetitionType type;
  final List<DateTime>? callTime;
  final String? prizeName;
  final String? phone;
  final String? msgInit;

  Competition(
    this.title,
    this.endDate,
    this.imgPath,
    this.type,
    this.callTime,
    this.prizeName,
    this.phone,
    this.msgInit,
  );
}
