import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innotest/src/models/user_model.dart';

part 'app_repository.freezed.dart';

final appRepositoryProvider =
    StateNotifierProvider<AppRepositoryModel, AppRepositoryState>(
  (ref) => AppRepositoryModel(
    ref: ref,
  ),
);

class AppRepositoryModel extends StateNotifier<AppRepositoryState> {
  final StateNotifierProviderRef ref;
  StreamSubscription<User?>? _authStateChanges;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppRepositoryModel({
    required this.ref,
  }) : super(AppRepositoryState());

  checkLoggedInUser() async {
    state = state.copyWith(appStatus: AppState.authenticating);
    _authStateChanges = _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        setAppStatus(AppState.unauthenticated);
      } else {
        final u = UserModel()
          ..email = user.email!
          ..id = user.uid
          ..name = user.displayName;

        setAppStatus(AppState.authenticated);
        state = state.copyWith(appStatus: AppState.authenticated, userModel: u);
      }
    });
    final user = _auth.currentUser;
    if (user != null) {
      final u = UserModel()
        ..email = user.email!
        ..id = user.uid
        ..name = user.displayName;
      state = state.copyWith(appStatus: AppState.authenticated, userModel: u);

      return;
    }
    state = state.copyWith(appStatus: AppState.unauthenticated);
  }

  updateData() async {}

  logout() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
      removeUser();
    }
  }

  void setUser(UserModel userModel) {
    state = state.copyWith(
      userModel: userModel,
      appStatus: AppState.authenticated,
    );
  }

  void removeUser() {
    state = state.copyWith(
      userModel: null,
      appStatus: AppState.unauthenticated,
    );
  }

  void setAppStatus(AppState appState) {
    state = state.copyWith(appStatus: appState);
  }

  void setErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }
}

@freezed
class AppRepositoryState with _$AppRepositoryState {
  factory AppRepositoryState({
    UserModel? userModel,
    @Default(AppState.authenticating) AppState appStatus,
    String? errorMessage,
  }) = _AppRepositoryState;
}

enum AppState {
  authenticating,
  authenticated,
  unauthenticated,
  failed,
}
