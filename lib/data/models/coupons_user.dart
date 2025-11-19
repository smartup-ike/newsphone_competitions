class Couponsuser {
  final int id;
  final String firebaseUid;
  final String phoneNumber;
  final int couponBalance;
  final DateTime createdAt;

  Couponsuser({
    required this.id,
    required this.firebaseUid,
    required this.phoneNumber,
    required this.couponBalance,
    required this.createdAt,
  });

  factory Couponsuser.fromJson(Map<String, dynamic> json) {
    return Couponsuser(
      id: json['id'] ?? 0,
      firebaseUid: json['firebase_uid'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      couponBalance: json['coupon_balance'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
