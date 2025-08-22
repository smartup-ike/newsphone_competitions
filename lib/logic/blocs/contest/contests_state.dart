part of 'contests_cubit.dart';

abstract class ContestsState extends Equatable {
  const ContestsState();

  @override
  List<Object?> get props => [];
}

class ContestsInitial extends ContestsState {}

class ContestsLoading extends ContestsState {}

class ContestsLoaded extends ContestsState {
  final List<Content> contests;
  final String selectedCategory;

  const ContestsLoaded(this.contests, {this.selectedCategory = 'ΌΛΑ'});

  @override
  List<Object?> get props => [contests, selectedCategory];
}

class ContestsError extends ContestsState {
  final String message;

  const ContestsError(this.message);

  @override
  List<Object?> get props => [message];
}
