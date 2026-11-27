import '../../flavors/flavor_config.dart';

/// Station details the backend returns from `GET /brand` (per `X-Brand`).
///
/// They live on the server so they can change without an app update.
/// [Brand.fromFlavor] gives the built-in values used until the server answers.
class Brand {
  const Brand({
    required this.id,
    required this.callNumber,
    required this.smsNumber,
    required this.generalTopic,
    this.appConfig = const {},
  });

  /// The app number, e.g. `14800`. Must match the flavor's `appId`.
  final String id;

  /// Number users call to take part.
  final String callNumber;

  /// Number users send the SMS to (may differ from [callNumber]).
  final String smsNumber;

  /// FCM topic every install of this app subscribes to.
  final String generalTopic;

  /// Extra settings from the backend. Not used yet.
  final Map<String, dynamic> appConfig;

  /// Built-in values from the flavor.
  factory Brand.fromFlavor(FlavorConfig flavor) => Brand(
    id: flavor.appId,
    callNumber: flavor.phoneNumber,
    smsNumber: flavor.phoneNumber,
    generalTopic: flavor.notificationsTopic,
  );

  /// Throws [FormatException] if a required value is missing or empty.
  factory Brand.fromJson(Map<String, dynamic> json) {
    String required(String key) {
      final value = json[key];
      if (value == null || value.toString().trim().isEmpty) {
        throw FormatException('Brand: missing "$key"');
      }
      return value.toString().trim();
    }

    final config = json['app_config'];
    return Brand(
      id: required('id'),
      callNumber: required('call_number'),
      smsNumber: required('sms_number'),
      generalTopic: required('general_topic'),
      appConfig: config is Map ? Map<String, dynamic>.from(config) : const {},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'call_number': callNumber,
    'sms_number': smsNumber,
    'general_topic': generalTopic,
    'app_config': appConfig,
  };

  @override
  bool operator ==(Object other) =>
      other is Brand &&
      other.id == id &&
      other.callNumber == callNumber &&
      other.smsNumber == smsNumber &&
      other.generalTopic == generalTopic;

  @override
  int get hashCode => Object.hash(id, callNumber, smsNumber, generalTopic);
}
