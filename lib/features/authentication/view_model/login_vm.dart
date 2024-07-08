import 'dart:async';

import 'package:creama/features/authentication/repository/auth_repo.dart';
import 'package:creama/utils/error_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends AsyncNotifier {
  late final AuthenticationRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(authRepo);
  }

  Future<void> logIn(
      String email, String password, BuildContext context) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email: email, password: password),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go('/home');
    }
  }
}

final logInViewModelProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
