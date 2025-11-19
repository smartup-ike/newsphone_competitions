import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/coupons_user.dart';
import '../../../data/models/user_transaction.dart';
import '../../../data/services/api_service.dart';
part 'coupons_state.dart';

class CouponsCubit extends Cubit<CouponsState> {
  final FirebaseAuth _auth;
  final ApiService _apiService;

  CouponsCubit(this._auth, this._apiService) : super(const CouponsState());

  Future<void> init() async {
    await loadCoupons();
    await loadTransactions();
  }

  Future<void> loadCoupons() async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final user = _auth.currentUser;
      print('user: $user');
      if (user == null) throw Exception("User not logged in");

      final idToken = await user.getIdToken(true);

      final meJson = await _apiService.fetchMe(idToken!);

      final me = Couponsuser.fromJson(meJson);

      print('me: $me');

      emit(state.copyWith(
        loading: false,
        user: me,
      ));

    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> loadTransactions() async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final idToken = await user.getIdToken(true);

      final transactions = await _apiService.fetchCouponHistory(idToken!);

      emit(state.copyWith(
        loading: false,
        transactions: transactions,
      ));
    } catch (e) {
      print('asdf');
      emit(state.copyWith(
        loading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> spendOnContest(int amount, String contestId) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final idToken = await user.getIdToken(true);

      final result = await _apiService.spendCoupons(
        idToken: idToken!,
        amount: amount,
        contestId: int.tryParse(contestId),
      );

      // Reload the user to update coupon balance
      await loadCoupons();

      emit(state.copyWith(loading: false));
      print('Spend result: $result');
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

}

