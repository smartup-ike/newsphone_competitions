import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constans/constants.dart';
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

  void filterContests({ConsCategories? special, String? normal}) {
    List<Contest> filtered;

    if (special == ConsCategories.all || (special == null && (normal == null || normal == 'ΟΛΑ'))) {
      filtered = _allContests;
    } else if (special == ConsCategories.bigContests) {
      filtered = _allContests.where((c) => c.isBigContest == true).toList();
    } else {
      filtered = _allContests.where((c) => c.category?.name == normal).toList();
    }

    final selectedCategory = special?.name ?? normal ?? ConsCategories.all.name;
    emit(ContestsLoaded(filtered, selectedCategory: selectedCategory));
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
                .where((contest) => contest.category?.name == currentCategory)
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
