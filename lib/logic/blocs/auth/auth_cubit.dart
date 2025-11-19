import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth;

  final ApiService _apiService;

  AuthCubit(this._auth, this._apiService) : super(const AuthState.unknown()) {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        // Emit authenticated state
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
        registerUser();
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  void verifyPhone(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        print("Phone verification failed: $e");
      },
      codeSent: (verificationId, resendToken) {
        emit(state.copyWith(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        emit(state.copyWith(verificationId: verificationId));
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
      await _auth.signInWithCredential(credential);

      // Only mark success after Firebase auth completes
      emit(state.copyWith(smsStatus: SmsStatus.success, errorMessage: null));
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


  void signOut() async {
    await _auth.signOut();
  }
}
