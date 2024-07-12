import 'package:creama/features/authentication/view_model/signup_vm.dart';
import 'package:creama/features/authentication/views/login_screen.dart';
import 'package:creama/features/authentication/widgets/auth_form_field.dart';
import 'package:creama/features/authentication/widgets/form_button.dart';
import 'package:creama/features/authentication/widgets/form_check.dart';
import 'package:creama/features/home/view/home_screen.dart';
import 'package:creama/main_screen.dart';
import 'package:creama/utils/gaps.dart';
import 'package:creama/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeURL = "/signup";
  static const routeName = 'signUp';
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var formValues = <String, String>{};

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSaved({required String key, required String value}) {
    formValues[key] = value;
  }

  void _onSignUpPressed() async {
    final formstate = _formKey.currentState!;
    //애러가 있나없나 확인
    final valid = formstate.validate();
    if (!valid) {
      return;
    }
    formstate.save();
    await ref.read(signupProvider.notifier).signUp(
          email: formValues['email']!,
          password: formValues['password']!,
        );

    if (mounted) {
      context.go('/home');
    }
  }

  void _onLoginTap(BuildContext context) {
    //유저가 보고있는 현제 페이지를 날림
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signupProvider).isLoading;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Column(
            children: [
              Gaps.v96,
              Gaps.v96,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthFormField(
                      hintText: '이메일 형식을 지켜주세요.',
                      validator: FormCheck.emailCheck,
                      onSaved: (value) => _onSaved(key: 'email', value: value!),
                    ),
                    Gaps.v20,
                    AuthFormField(
                      hintText: '비밀번호는 8글자 이상이어야 해요.',
                      validator: FormCheck.passwordCheck,
                      onSaved: (value) =>
                          _onSaved(key: 'password', value: value!),
                    ),
                    Gaps.v20,
                    AuthFormButton(
                        title: '카페 가입',
                        onPressed: _onSignUpPressed,
                        isEnabled: !isLoading),
                  ],
                ),
              ),
              Gaps.v80,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: const Text(
                  '이미 가입 했어요.',
                  style: TextStyle(fontSize: Sizes.size20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
