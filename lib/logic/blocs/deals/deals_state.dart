
part of 'deals_cubit.dart';

/// Represents the state of the deals data fetching process.
abstract class DealsState {}

/// Initial state, before any data is fetched.
class DealsInitial extends DealsState {}

/// State when data is being loaded.
class DealsLoading extends DealsState {}

/// State when data is successfully loaded.
class DealsLoaded extends DealsState {
  final List<Deal> deals;
  DealsLoaded(this.deals);
}

/// State when an error occurs.
class DealsError extends DealsState {
  final String message;
  DealsError(this.message);
}