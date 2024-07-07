import 'package:creama/features/authentication/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeURL = "/signup";
  static const routeName = 'signUp';
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    //유저가 보고있는 현제 페이지를 날림
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold();
  }
}
