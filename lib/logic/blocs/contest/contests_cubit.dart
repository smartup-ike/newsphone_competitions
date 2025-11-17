import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/data/models/contest_categories.dart';

import '../../../data/models/contests.dart';
import '../../../data/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'contests_state.dart';

class ContestsCubit extends Cubit<ContestsState> {
  List<Contest> _allContests = [];
  final ApiService _apiService;

  ContestsCubit(this._apiService) : super(ContestsInitial());

  Future<void> init() async {
    await fetchContests();
  }

  void filterContests(String category) {
    List<Contest> filteredList;
    if (category == 'ΟΛΑ') {
      filteredList = _allContests;
    } else if (category == 'Μεγάλοι διαγωνισμοί') {
      filteredList =
          _allContests
              .where((contest) => contest.isBigContest == true)
              .toList();
    } else {
      filteredList =
          _allContests
              .where((contest) => contest.contentsType == category)
              .toList();
    }
    emit(ContestsLoaded(filteredList, selectedCategory: category));
  }

  // The new, updated searchContests method
  void searchContests(String query) {
    List<Contest> listToFilter;
    String currentCategory = 'ΟΛΑ';
    if (state is ContestsLoaded) {
      ContestsLoaded currentState = state as ContestsLoaded;
      currentCategory = currentState.selectedCategory;

      if (currentCategory == 'ΟΛΑ') {
        listToFilter = _allContests;
      } else {
        listToFilter =
            _allContests
                .where((contest) => contest.contentsType == currentCategory)
                .toList();
      }
    } else {
      listToFilter = _allContests;
    }

    List<Contest> filteredList;
    if (query.isEmpty) {
      filteredList = listToFilter;
    } else {
      filteredList =
          listToFilter
              .where(
                (contest) =>
                    contest.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    emit(ContestsLoaded(filteredList, selectedCategory: currentCategory));
  }

  Future<void> fetchContests() async {
    emit(ContestsLoading());
    try {
      List<Contest> fetchedContests = await _apiService.fetchContests();

      _allContests = fetchedContests;

      final now = DateTime.now();

      List<Contest> upcomingContests =
          _allContests
              .where((contest) => contest.dateEnd.isAfter(now))
              .toList();
      List<Contest> pastContests =
          _allContests
              .where((contest) => contest.dateEnd.isBefore(now))
              .toList();

      upcomingContests.sort((a, b) => a.dateEnd.compareTo(b.dateEnd));
      pastContests.sort((a, b) => a.dateEnd.compareTo(b.dateEnd));

      List<Contest> sortedContests = [...upcomingContests, ...pastContests];

      // 🔹 Always emit with selectedCategory (default "ΟΛΑ")
      emit(ContestsLoaded(sortedContests, selectedCategory: 'ΟΛΑ'));
    } catch (e) {
      emit(ContestsError("Failed to fetch contests. $e"));
    }
  }
}
