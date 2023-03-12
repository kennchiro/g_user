import 'package:flutter/material.dart';
import 'package:g_user/Pages/Home/user_add_page.dart';

import '../Pages/Authentication/signIn_page.dart';
import '../Pages/Authentication/signUp_page.dart';
import '../Pages/Home/home_page.dart';

class GUserRoute {
   static Route<dynamic> onGenerateRoute(settings) {
    if (settings.name == "/signUpPage") {
      return PageRouteBuilder(
          settings:
              settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
          pageBuilder: (_, __, ___) => const SignUpPage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c));
    }
    if (settings.name == "/signInPage") {
      return PageRouteBuilder(
          settings:
              settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
          pageBuilder: (_, __, ___) => const SignInPage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c));
    }

        if (settings.name == "/userAddPage") {
      return PageRouteBuilder(
          settings:
              settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
          pageBuilder: (_, __, ___) => const UserAddPage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c));
    }
    // Unknown route
    return MaterialPageRoute(builder: (_) => const HomePage());
  }
}