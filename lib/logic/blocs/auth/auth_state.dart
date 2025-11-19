part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }
enum SmsStatus { initial, success, failure }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? verificationId;
  final Map<String, dynamic>? backendUserData;
  final String? errorMessage;
  final SmsStatus smsStatus;

  const AuthState({
    required this.status,
    this.user,
    this.verificationId,
    this.backendUserData,
    this.smsStatus = SmsStatus.initial,
    this.errorMessage,
  });

  const AuthState.unknown() : this(status: AuthStatus.unknown);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? verificationId,
    Map<String, dynamic>? backendUserData,
    String? errorMessage,
    SmsStatus? smsStatus,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: status == AuthStatus.unauthenticated ? null : (user ?? this.user),
      verificationId: verificationId ?? this.verificationId,
      backendUserData: backendUserData ?? this.backendUserData,
      errorMessage: errorMessage ?? this.errorMessage,
      smsStatus: smsStatus ?? this.smsStatus,
    );
  }
}
