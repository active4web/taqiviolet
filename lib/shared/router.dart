import 'package:flutter/material.dart';
import 'package:safsofa/screens/home_layout.dart';
import 'package:safsofa/screens/splash_and_onboarding/onboarding.dart';
import 'package:safsofa/screens/splash_and_onboarding/splash_screen.dart';

// class Routes {
//   static const String SplashScreen = "/";
//   static const String onBoardingRoute = "/onBoarding";
//   static const String loginRoute = "/login";
//   static const String registerRoute = "/register";
//   static const String forgotPasswordRoute = "/forgotPassword";
//   static const String mainRoute = "/mainRoute";
//   static const String storeDetailsRoute = "/storeDetails";
// }

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

//  Route<dynamic>? getRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case Routes.SplashScreen:
//       return MaterialPageRoute(builder: (_) => SplashScreen());
//     case Routes.onBoardingRoute:
//       return MaterialPageRoute(builder: (_) => OnboardingView());
//     case Routes.mainRoute:
//       return MaterialPageRoute(builder: (_) => HomeLayout());
//   }
// }

class MagicRouter {
  static BuildContext? currentContext = navigatorKey.currentContext;

  static Future<dynamic> navigateTo(Widget page) =>
      navigatorKey.currentState!.push(_materialPageRoute(page));

  static Future<dynamic> navigateAndPopAll(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
        _materialPageRoute(page),
        (_) => false,
      );

  static Future<dynamic> navigateAndPopUntilFirstPage(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
          _materialPageRoute(page), (route) => route.isFirst);

  static void pop() => navigatorKey.currentState?.pop();

  static Route<dynamic> _materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}
