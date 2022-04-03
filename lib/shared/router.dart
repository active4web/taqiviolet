import 'package:flutter/material.dart';
import 'package:safsofa/screens/bottom_navigation_screens/home_screen.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/onboarding/view.dart';

class Routes {
  static const String onBoardingRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/mainRoute";
  static const String storeDetailsRoute = "/storeDetails";
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.onBoardingRoute:
      return MaterialPageRoute(builder: (_) => OnboardingView());
    case Routes.mainRoute:
      return MaterialPageRoute(builder: (_) => HomeLayout());
  }
}

class MagicRouter {
  static BuildContext currentContext = navigatorKey.currentContext;

  static Future<dynamic> navigateTo(Widget page) =>
      navigatorKey.currentState.push(_materialPageRoute(page));

  static Future<dynamic> navigateAndPopAll(Widget page) =>
      navigatorKey.currentState.pushAndRemoveUntil(
        _materialPageRoute(page),
        (_) => false,
      );

  static Future<dynamic> navigateAndPopUntilFirstPage(Widget page) =>
      navigatorKey.currentState.pushAndRemoveUntil(
          _materialPageRoute(page), (route) => route.isFirst);

  static void pop() => navigatorKey.currentState.pop();

  static Route<dynamic> _materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}
