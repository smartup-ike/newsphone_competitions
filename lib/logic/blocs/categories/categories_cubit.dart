import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsphone_competitions/core/constans/constants.dart';
import '../../../data/models/contest_categories.dart';
import '../../../data/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final ApiService _apiService;
  ConsCategories? selectedSpecialCategory;
  String? selectedNormalCategory;

  CategoriesCubit(this._apiService) : super(CategoriesInitial());

  Future<void> init() async {
    await fetchCategories();
  }

  void selectCategory({ConsCategories? special, String? normal}) {
    if (state is CategoriesLoaded) {
      final loaded = state as CategoriesLoaded;
      emit(loaded.copyWith(
        selectedSpecialCategory: special,
        selectedNormalCategory: normal,
        resetSpecial: normal != null,
        resetNormal: special != null,
      ));
    }
  }

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      List<ContestCategories> fetchedContests =
          await _apiService.fetchCategories();

      emit(CategoriesLoaded(fetchedContests));
    } catch (e) {
      emit(CategoriesError("Failed to fetch contests. $e"));
    }
  }
}
