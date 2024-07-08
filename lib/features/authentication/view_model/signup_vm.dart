import 'dart:async';

import 'package:creama/features/authentication/repository/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp({required String email, required String password}) async {
    //시작할때 로딩중이라고 알리고
    state = const AsyncValue.loading();

    //끝나면 로딩상태 없애기
    state = await AsyncValue.guard(
      () async => await _authRepo.signUp(email: email, password: password),
    );
    // if (state.hasError) {
    //   showFirebaseErrorSnack(context, state.error);
    // }
    // else {
    //   context.goNamed(InterestScreen.routeName);
    // }
  }
}

final signUpForm = StateProvider((ref) => {});

final signupProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
