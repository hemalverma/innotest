import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innotest/src/models/product_model.dart';

import '../../logic/services/api/api_service.dart';
import '../../models/response/api_response.dart';

part 'home_page_model.freezed.dart';

//provider
final homePageModelProvider =
    StateNotifierProvider<HomePageModel, HomePageState>(
  (ref) => HomePageModel(
    apiService: ref.watch(apiServiceProvider),
    ref: ref,
  ),
);

//view_model
class HomePageModel extends StateNotifier<HomePageState> {
  final ApiService apiService;
  StateNotifierProviderRef ref;

  HomePageModel({
    required this.apiService,
    required this.ref,
  }) : super(const HomePageState());

  Future<List<ProductModel>> fetchProducts(int limit, int offset) async {
    final response = await apiService.getProducts(limit: limit, offset: offset);
    if (response.status == ApiStatus.success) {
      return response.data ?? [];
    } else {
      return [];
    }
  }

  setError(String error) {
    state = state.copyWith(
      errorMessage: error,
      status: HomeStatus.error,
    );
  }
}

//state
@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    List<ProductModel>? notes,
    @Default(HomeStatus.loading) HomeStatus status,
    String? errorMessage,
  }) = _HomePageState;
}

enum HomeStatus {
  loading,
  loaded,
  error,
}
