class UserTransaction {
  final int id;
  final int userId;
  final int couponsSpent;
  final DateTime transactionDate;
  final int contestId;
  final int dealId;
  final String targetName;

  UserTransaction({
    required this.id,
    required this.userId,
    required this.couponsSpent,
    required this.transactionDate,
    required this.contestId,
    required this.dealId,
    required this.targetName,
  });

  factory UserTransaction.fromJson(Map<String, dynamic> json) {
    return UserTransaction(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      couponsSpent: json['coupons_spent'] ?? 0,
      transactionDate: DateTime.parse(json['transaction_date']),
      contestId: json['contest_id'] ?? 0,
      dealId: json['deal_id'] ?? 0,
      targetName: json['target_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'coupons_spent': couponsSpent,
      'transaction_date': transactionDate.toIso8601String(),
      'contest_id': contestId,
      'deal_id': dealId,
      'target_name': targetName,
    };
  }
}
