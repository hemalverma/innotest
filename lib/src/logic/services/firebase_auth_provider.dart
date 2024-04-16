import 'package:innotest/src/models/response/api_response.dart';
import 'package:innotest/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<ApiResponse<UserCredential>> createUser(
      UserModel userModel) async {
    final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userModel.email!,
      password: userModel.password!,
    );
    if (res.user != null) {
      return ApiResponse<UserCredential>.success(res);
    }
    return ApiResponse.error(res.hashCode.toString());
  }

  static Future<ApiResponse<User?>> login(String email, String password) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (user.user != null) {
      return ApiResponse<User?>.success(user.user);
    }
    return ApiResponse.error(user.hashCode.toString());
  }
}
