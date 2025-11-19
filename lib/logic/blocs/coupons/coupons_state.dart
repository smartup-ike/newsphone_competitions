part of 'cupons_cubit.dart';

class CouponsState extends Equatable {
  final bool loading;
  final Couponsuser? user;
  final List<UserTransaction> transactions;
  final String? error;

  const CouponsState({
    this.loading = false,
    this.user,
    this.transactions = const [],
    this.error,
  });

  CouponsState copyWith({
    bool? loading,
    Couponsuser? user,
    List<UserTransaction>? transactions,
    String? error,
  }) {
    return CouponsState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      transactions: transactions ?? this.transactions,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, user, transactions, error];
}