import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innotest/src/models/product_model.dart';
import 'package:innotest/src/models/user_model.dart';

import '../../../models/response/api_response.dart';
import 'api_service_impl.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiServiceImpl(),
);

abstract class ApiService {
  Future<ApiResponse<UserCredential>> createUser({
    required UserModel user,
  });
  Future<ApiResponse<UserModel>> login({
    required String email,
    required String password,
  });
  Future<ApiResponse<List<ProductModel>>> getProducts({
    required int limit,
    required int offset,
    String? search,
  });
}
