class Deal {
  final String id;
  final String name;
  final String? dealImage;
  final String? companyImage;
  final String? details;
  final String? terms;
  final String dealCode;
  final bool? isActive;

  Deal({
    required this.id,
    required this.name,
    this.dealImage,
    this.companyImage,
    this.details,
    this.terms,
    required this.dealCode,
    this.isActive,
  });

  /// Factory for creating Deal from JSON
  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'] as String,
      name: json['name'] as String,
      dealImage: json['dealImage'] as String?,
      companyImage: json['companyImage'] as String?,
      details: json['details'] as String?,
      terms: json['terms'] as String?,
      dealCode: json['dealCode'] as String,
      isActive: json['is_active'] as bool?,
    );
  }

  /// Convert Deal object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dealImage': dealImage,
      'companyImage': companyImage,
      'details': details,
      'terms': terms,
      'dealCode': dealCode,
      'is_active': isActive,
    };
  }

  /// Copy with helper (useful in Bloc updates)
  Deal copyWith({
    String? id,
    String? name,
    String? dealImage,
    String? companyImage,
    String? details,
    String? terms,
    String? dealCode,
    bool? isActive,
  }) {
    return Deal(
      id: id ?? this.id,
      name: name ?? this.name,
      dealImage: dealImage ?? this.dealImage,
      companyImage: companyImage ?? this.companyImage,
      details: details ?? this.details,
      terms: terms ?? this.terms,
      dealCode: dealCode ?? this.dealCode,
      isActive: isActive ?? this.isActive,
    );
  }
}
