import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:innotest/src/models/response/api_response.dart';
import 'package:innotest/src/models/user_model.dart';

import '../../../models/product_model.dart';
import '../firebase_auth_provider.dart';
import 'api_client.dart';
import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  late Dio _dio;

  ApiServiceImpl() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 50000),
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! <= 500;
        },
        baseUrl: ApiClient.baseUrl,
        headers: {
          'content-Type': 'application/json',
        },
      ),
    );
  }

  @override
  Future<ApiResponse<UserCredential>> createUser({
    required UserModel user,
  }) async {
    try {
      final response = await FirebaseService.createUser(user);
      if (response.status == ApiStatus.success) {
        if (response.data == null) {
          return ApiResponse<UserCredential>.error('Registration Failed');
        }
        return ApiResponse<UserCredential>.success(response.data!);
      }
      return ApiResponse<UserCredential>.error(response.errorMessage);
    } catch (e) {
      return ApiResponse<UserCredential>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await FirebaseService.login(email, password);
      if (response.status == ApiStatus.success) {
        if (response.data == null) {
          return ApiResponse<UserModel>.error('User Does not Exist');
        }
        return ApiResponse<UserModel>.success(UserModel()
          ..email = response.data!.email!
          ..id = response.data!.uid
          ..name = response.data!.displayName);
      }
      return ApiResponse<UserModel>.error(response.errorMessage);
    } catch (e) {
      return ApiResponse<UserModel>.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<ProductModel>>> getProducts({
    required int limit,
    required int offset,
    String? search,
  }) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: {
          'limit': limit,
          'offset': offset,
          'search': search,
        },
      );
      if (response.statusCode == 200) {
        if (response.data == null) {
          return ApiResponse<List<ProductModel>>.error('No Products Found');
        }
        return ApiResponse<List<ProductModel>>.success(
          (response.data as List).map((e) => ProductModel.fromJson(e)).toList(),
        );
      }
      return ApiResponse<List<ProductModel>>.error(response.statusMessage);
    } catch (e) {
      return ApiResponse<List<ProductModel>>.error(e.toString());
    }
  }
}
