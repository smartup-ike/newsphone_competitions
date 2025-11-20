import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth;

  final ApiService _apiService;

  Timer? _timer;

  AuthCubit(this._auth, this._apiService) : super(const AuthState.unknown()) {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        // Emit authenticated state
        emit(state.copyWith(status: AuthStatus.authenticated, user: user,isNewUser: true));
        registerUser();
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  void verifyPhone(String phoneNumber) async {
    emit(state.copyWith(loading: true, canResend: false, resendSeconds: 60));
    _startResendTimer();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        print("Phone verification failed: $e");
        emit(state.copyWith(loading: false)); // stop loading
      },
      codeSent: (verificationId, resendToken) {
        emit(state.copyWith(verificationId: verificationId, loading: false));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        emit(state.copyWith(verificationId: verificationId, loading: false));
      },
    );
  }


  void signInWithSms(String smsCode) async {
    if (state.verificationId == null) return;

    final credential = PhoneAuthProvider.credential(
      verificationId: state.verificationId!,
      smsCode: smsCode,
    );

    try {
      final result = await _auth.signInWithCredential(credential);

      final bool isNew = result.additionalUserInfo?.isNewUser ?? false;

      emit(state.copyWith(
        smsStatus: SmsStatus.success,
        errorMessage: null,
        isNewUser: isNew,
      ));
    } catch (e) {
      emit(state.copyWith(
        smsStatus: SmsStatus.failure,
        errorMessage: 'Λανθασμένος κωδικός',
      ));
    }
  }

  void registerUser() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // Get Firebase ID token
      final idToken = await user.getIdToken(true);

      if (idToken == null) {
        throw Exception('Failed to get Firebase ID token.');
      }

      // Call API to register user
      final result = await _apiService.registerUser(idToken);

      print('User registered in backend: $result');

      // Update state with backend info
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        backendUserData: result,
      ));
    } catch (e) {
      print('Failed to register user: $e');
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      ));
    }
  }

  void resendSms(String phone) {
    emit(state.copyWith(canResend: false, resendSeconds: 60));
    _startResendTimer();
    verifyPhone(phone);
  }

  void _startResendTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final sec = state.resendSeconds;

      if (sec == 0) {
        timer.cancel();
        emit(state.copyWith(canResend: true));
      } else {
        emit(state.copyWith(resendSeconds: sec - 1));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
  Future<void> signOut() async {
    await _auth.signOut();
    _timer?.cancel();

    // Reset state and set verificationId to null
    emit(state.clear(
      status: AuthStatus.unknown,
      user: null,
      verificationId: null,
      smsStatus: SmsStatus.initial,
      isNewUser: null,
      errorMessage: null,
      resendSeconds: 60,
      canResend: false,
    ));
    emit(const AuthState.unauthenticated());
  }
}
