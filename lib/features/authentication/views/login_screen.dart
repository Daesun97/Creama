import 'package:creama/features/authentication/view_model/login_vm.dart';
import 'package:creama/features/authentication/views/signin_screen.dart';
import 'package:creama/features/authentication/widgets/auth_form_field.dart';
import 'package:creama/features/authentication/widgets/form_button.dart';
import 'package:creama/features/authentication/widgets/form_check.dart';
import 'package:creama/utils/gaps.dart';
import 'package:creama/utils/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends ConsumerStatefulWidget {
  static String routeURL = "/";
  static String routeName = "login";
  const LogInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  var formValues = <String, String>{};

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSaved({required String key, required String value}) {
    formValues[key] = value;
  }

  void _onLogInPress() async {
    final formState = _formKey.currentState!;
    final valid = formState.validate();
    if (!valid) {
      return;
    }
    formState.save();

    await ref.read(logInViewModelProvider.notifier).logIn(
          formValues['email']!,
          formValues['password']!,
          context,
        );
    if (mounted) {
      context.go('/home');
    }
  }

  void _onCreateAccountPressed(BuildContext context) {
    context.pushNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(logInViewModelProvider).isLoading;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size18),
          child: Column(
            children: [
              //title이나 이모티콘이나 애니메이션 여기 삽입
              Gaps.v80,
              Gaps.v80,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthFormField(
                      hintText: '아이디',
                      validator: FormCheck.emailCheck,
                      onSaved: (value) => _onSaved(key: 'email', value: value!),
                    ),
                    Gaps.v20,
                    AuthFormField(
                      hintText: '비밀번호',
                      validator: FormCheck.passwordCheck,
                      onSaved: (value) =>
                          _onSaved(key: 'password', value: value!),
                    ),
                    Gaps.v20,
                    AuthFormButton(
                      title: '커피 한 잔',
                      onPressed: _onLogInPress,
                      isEnabled: !isLoading,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _onCreateAccountPressed(context),
                  child: const Text(
                    '첫 손님',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size24,
                        color: Color(0xFF452F2B)),
                  ),
                ),
                Gaps.v40
              ],
            ),
          ),
        ),
      ),
    );
  }
}
