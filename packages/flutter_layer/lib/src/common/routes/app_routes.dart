import 'package:flutter/material.dart';
import 'package:flutter_layer/src/view/home/home_page.dart';

class AppRoutes {
  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String settingsRoute = '/settings';
  static const String gameRoute = '/game';

  Route<void>? onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    // final RouteParameters? parameters =
    // settings.arguments as RouteParameters?;
    final Widget page;
    switch (name) {
      case gameRoute:
      // page = const GamePage();
      case homeRoute:
      default:
        page = const HomePage();
    }
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }

  const AppRoutes();
}
