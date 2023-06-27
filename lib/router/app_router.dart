import 'package:flutter/material.dart';
import 'package:flutter_new_projects/features/add_pages/pages/schedule_page.dart';
import 'package:flutter_new_projects/features/home_page/pages/home_page.dart';

import '../features/auth_page/pages/sign_in_page.dart';
import '../features/auth_page/pages/sing_up_page.dart';
import 'app_route_name.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      // case AppRouteName.signIn:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginPage(),
      //     settings: settings,
      //   );
      case AppRouteName.signUp:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (animation, __, child) => const SignUpPage(),
          transitionDuration: const Duration(
            milliseconds: 500,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(
                  0,
                  1,
                ),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      case AppRouteName.signIn:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (animation, __, child) => const SignInPage(),
          transitionDuration: const Duration(
            milliseconds: 500,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      case AppRouteName.homePage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (animation, __, child) => const HomePage(),
          transitionDuration: const Duration(
            milliseconds: 300,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      case AppRouteName.schedulePage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (animation, __, child) => const SchedulePage(),
          transitionDuration: const Duration(
            milliseconds: 300,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
    }

    return null;
  }
}
