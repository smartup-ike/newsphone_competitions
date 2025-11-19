part of 'cupons_cubit.dart';

class CouponsState extends Equatable {
  final bool loading;
  final Couponsuser? user;
  final String? error;

  const CouponsState({
    this.loading = false,
    this.user,
    this.error,
  });

  CouponsState copyWith({
    bool? loading,
    Couponsuser? user,
    String? error,
  }) {
    return CouponsState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, user, error];
}

