part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<ContestCategories> categories;
  final ConsCategories? selectedSpecialCategory;
  final String? selectedNormalCategory;

  const CategoriesLoaded(
      this.categories, {
        this.selectedSpecialCategory,
        this.selectedNormalCategory,
      });

  CategoriesLoaded copyWith({
    List<ContestCategories>? categories,
    ConsCategories? selectedSpecialCategory,
    String? selectedNormalCategory,
    bool resetSpecial = false,
    bool resetNormal = false,
  }) {
    return CategoriesLoaded(
      categories ?? this.categories,
      selectedSpecialCategory: resetSpecial ? null : (selectedSpecialCategory ?? this.selectedSpecialCategory),
      selectedNormalCategory: resetNormal ? null : (selectedNormalCategory ?? this.selectedNormalCategory),
    );
  }

  String get selectedCategoryName {
    return selectedSpecialCategory?.name ?? selectedNormalCategory ?? ConsCategories.all.name;
  }

  @override
  List<Object?> get props => [categories, selectedSpecialCategory, selectedNormalCategory];
}


class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}
