import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contests.dart';
import '../../../data/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'contests_state.dart';

class ContestsCubit extends Cubit<ContestsState> {
  List<Content> _allContests = [];
  ContestsCubit() : super(ContestsInitial());


  Future<void> fetchAndSortContests() async {
    emit(ContestsLoading());
    try {
      // Use the external fetchContests() function to get the data
      List<Content> fetchedContests = await fetchContests();

      // Store the full list for filtering
      _allContests = fetchedContests;

      final now = DateTime.now();

      List<Content> upcomingContests = _allContests
          .where((contest) => contest.dateEnd.isAfter(now))
          .toList();
      List<Content> pastContests = _allContests
          .where((contest) => contest.dateEnd.isBefore(now))
          .toList();

      upcomingContests.sort((a, b) => a.dateEnd.compareTo(b.dateEnd));
      pastContests.sort((a, b) => a.dateEnd.compareTo(b.dateEnd));

      List<Content> sortedContests = [...upcomingContests, ...pastContests];

      emit(ContestsLoaded(sortedContests));
    } catch (e) {
      emit(ContestsError("Failed to fetch contests."));
    }
  }

  void filterContests(String category) {
    List<Content> filteredList;
    if (category == 'ΌΛΑ') {
      filteredList = _allContests;
    } else {
      filteredList = _allContests
          .where((contest) => contest.contentsType == category)
          .toList();
    }
    emit(ContestsLoaded(filteredList, selectedCategory: category));
  }
}