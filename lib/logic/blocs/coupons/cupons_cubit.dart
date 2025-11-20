import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/contests.dart';
import '../../../data/models/coupons_user.dart';
import '../../../data/models/user_transaction.dart';
import '../../../data/services/api_service.dart';

part 'coupons_state.dart';

class CouponsCubit extends Cubit<CouponsState> {
  final FirebaseAuth _auth;
  final ApiService _apiService;

  CouponsCubit(this._auth, this._apiService) : super(const CouponsState());

  Future<void> init() async {
    emit(state.copyWith(loading: true, error: null));

    final user = _auth.currentUser;
    if (user == null) {
      return;
    }

    try {
      await Future.wait([
        loadCoupons(),
        loadTransactions(),
        loadContests(),
      ]);

      emit(state.copyWith(loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
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

      emit(state.copyWith(loading: false, user: me));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> loadTransactions() async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final idToken = await user.getIdToken(true);

      final transactions = await _apiService.fetchCouponHistory(idToken!);

      emit(state.copyWith(loading: false, transactions: transactions));
    } catch (e) {
      print('asdf');
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> spendOnContest(int amount, String contestId) async {
    emit(state.copyWith(spendLoading: true, spendSuccess: false, error: null));

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final idToken = await user.getIdToken(true);

      await _apiService.spendCoupons(
        idToken: idToken!,
        amount: amount,
        contestId: int.parse(contestId),
      );

      await loadCoupons();

      emit(state.copyWith(spendLoading: false, spendSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          spendLoading: false,
          spendSuccess: false,
          error: "Something went wrong",
        ),
      );
    }
  }

  Future<void> loadContests() async {
    try {
      final contests = await _apiService.fetchContests();
      emit(state.copyWith(contests: contests));
    } catch (_) {
      // ignore errors, UI doesn't break
    }
  }

  String? getContestName(String contestId) {
    try {
      final contest = state.contests.firstWhere(
            (c) => c.id == contestId,
      );
      return contest.name;
    } catch (_) {
      return null;
    }
  }
}
