import 'package:creama/features/authentication/repository/auth_repo.dart';
import 'package:creama/features/authentication/views/login_screen.dart';
import 'package:creama/features/authentication/views/signin_screen.dart';
import 'package:creama/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: '/home',
      redirect: (context, state) {
        //유저가 로그인 됐는가 확인
        final isLogedIn = ref.read(authRepo).isLogedIn;
        //유저가 로그인이 안 돼있는데
        if (!isLogedIn) {
          //가입 화면이나 로그인 화면이 아니라면
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LogInScreen.routeURL) {
            //처음화면으로(가입)
            return LogInScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: LogInScreen.routeName,
          path: LogInScreen.routeURL,
          builder: (context, state) => const LogInScreen(),
        ),
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: '/:tab(home|post)',
          name: MainScreen.routeName,
          builder: (context, state) {
            final tab = state.params['tab']!;
            return MainScreen(
              tab: tab,
            );
          },
        ),
      ],
    );
  },
);
