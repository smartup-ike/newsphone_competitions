import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/deals.dart';
import '../../../data/services/api_service.dart';

part 'deals_state.dart';

/// The Cubit class that manages the state of the deals data.

class DealsCubit extends Cubit<DealsState> {
  List<Deal> _allDeals = [];
  final ApiService _apiService;

  DealsCubit(this._apiService) : super(DealsInitial());

  Future<void> init() async {
    await fetchDeals();
  }

  /// Fetches deals from the API and updates the state.
  Future<void> fetchDeals() async {
    emit(DealsLoading());
    try {
      List<Deal> fetchDeal = await _apiService.apiFetchDeals();
      _allDeals = fetchDeal;
      emit(DealsLoaded(_allDeals));
    } catch (e) {
      emit(DealsError("Failed to fetch deals."));
    }
  }

  /// Refresh the deals.
  Future<void> refreshDeals() async {
    emit(DealsLoading());
    try {
      List<Deal> fetchDeal = await _apiService.apiFetchDeals();
      _allDeals = fetchDeal;
      emit(DealsLoaded(_allDeals));
    } catch (e) {
      emit(DealsError("Failed to fetch deals."));
    }
  }
}
