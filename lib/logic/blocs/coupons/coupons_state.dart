part of 'cupons_cubit.dart';

class CouponsState extends Equatable {
  final bool loading;
  final Couponsuser? user;
  final List<UserTransaction> transactions;
  final String? error;
  final bool spendLoading;
  final bool spendSuccess;
  final List<Contest> contests;

  const CouponsState({
    this.loading = false,
    this.spendLoading = false,
    this.spendSuccess = false,
    this.user,
    this.transactions = const [],
    this.error,
    this.contests = const [],
  });

  CouponsState copyWith({
    bool? loading,
    Couponsuser? user,
    bool? spendLoading,
    bool? spendSuccess,
    List<UserTransaction>? transactions,
    List<Contest>? contests,
    String? error,
  }) {
    return CouponsState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      transactions: transactions ?? this.transactions,
      error: error,
      contests: contests ?? this.contests,
      spendLoading: spendLoading ?? this.spendLoading,
      spendSuccess: spendSuccess ?? this.spendSuccess,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    spendLoading,
    spendSuccess,
    contests,
    user,
    transactions,
    error,
  ];
}
