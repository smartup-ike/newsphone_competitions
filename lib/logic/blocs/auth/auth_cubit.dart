import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth;
  StreamSubscription<User?>? _authListener;
  PhoneAuthCredential? _autoVerifiedCredential;
  final ApiService _apiService;

  Timer? _timer;

  AuthCubit(this._auth, this._apiService) : super(const AuthState.unknown()) {
    _authListener = _auth.authStateChanges().listen((user) async {
      if (user != null) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user, isNewUser: true));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _authListener?.cancel();
    return super.close();
  }

  void verifyPhone(String phoneNumber) async {
    emit(state.copyWith(loading: true, canResend: false, resendSeconds: 60));
    _startResendTimer();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        // ✅ FIX 1: DO NOT call signInWithCredential immediately.
        // Instead, store the credential for the manual button press.
        _autoVerifiedCredential = credential;

        // Treat this path like a successful codeSent to transition the UI.
        // We use a dummy ID here to make the UI switch to the OTP screen.
        emit(state.copyWith(verificationId: 'auto_verified', loading: false));
      },
      verificationFailed: (e) {
        print("Phone verification failed: $e");
        emit(state.copyWith(
          loading: false,
          errorMessage: 'Ο αριθμός μπλοκαρίστηκε. Δοκιμάστε ξανά αργότερα',
        ));
      },
      codeSent: (verificationId, resendToken) {
        emit(state.copyWith(verificationId: verificationId, loading: false));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        emit(state.copyWith(verificationId: verificationId, loading: false));
      },
    );
  }

  void _handleSignInResult(UserCredential result) {
    final bool isNew = result.additionalUserInfo?.isNewUser ?? false;

    emit(state.copyWith(
      smsStatus: SmsStatus.success,
      errorMessage: null,
      isNewUser: isNew,
    ));
    registerUser();
  }

  // Inside AuthCubit.signInWithSms
  void signInWithSms(String smsCode) async {
    // Determine which credential to use
    final PhoneAuthCredential credential;

    if (_autoVerifiedCredential != null) {
      // Case 1: Auto-verification was successful (Android). Use the stored credential.
      credential = _autoVerifiedCredential!;
      _autoVerifiedCredential = null; // Consume and clear

    } else if (state.verificationId != null) {
      // Case 2: Manual SMS code entry. Build the credential from the input.
      credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!,
        smsCode: smsCode,
      );
    } else {
      // No verification ID and no auto-verified credential. Should not proceed.
      return;
    }

    try {
      // ✅ FIX 2: Only call signInWithCredential here, driven by the button press.
      final result = await _auth.signInWithCredential(credential);
      _handleSignInResult(result);

      // Clear verification ID regardless of how the sign-in succeeded
      emit(state.copyWith(verificationId: null));

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
  Future<void> signOut() async {
    await _auth.signOut();
    await _authListener?.cancel();

    // Fully reset AuthState
    emit(const AuthState.unauthenticated().clear(
      verificationId: null,
      smsStatus: SmsStatus.initial,
      isNewUser: null,
      errorMessage: null,
      resendSeconds: 60,
      canResend: false,
    ));
  }

  void clearSmsStatus() {
    emit(state.copyWith(smsStatus: SmsStatus.initial, errorMessage: null));
  }
  void clearPhone() {
    emit(state.copyWith(errorMessage: null));
  }
}
