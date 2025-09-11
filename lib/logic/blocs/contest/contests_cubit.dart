import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contests.dart';
import '../../../data/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'contests_state.dart';

class ContestsCubit extends Cubit<ContestsState> {
  List<Contest> _allContests = [];
  late ApiService _apiService;

  ContestsCubit() : super(ContestsInitial());

  Future<void> init(ApiService apiService) async {
    _apiService = apiService;
    await fetchContests();
  }

  void filterContests(String category) {
    List<Contest> filteredList;
    if (category == 'ΌΛΑ') {
      filteredList = _allContests;
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
    String currentCategory = 'ΌΛΑ';
    if (state is ContestsLoaded) {
      ContestsLoaded currentState = state as ContestsLoaded;
      currentCategory = currentState.selectedCategory;

      if (currentCategory == 'ΌΛΑ') {
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
      // Use the external fetchContests() function to get the data
      List<Contest> fetchedContests = await _apiService.fetchContests();

      // Store the full list for filtering
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

      emit(ContestsLoaded(sortedContests));
    } catch (e) {
      emit(ContestsError("Failed to fetch contests."));
    }
  }
}
