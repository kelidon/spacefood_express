import 'package:flutter/material.dart';
import 'package:spacefood_express/flutter_layer/home/home_page.dart';
import 'package:spacefood_express/game.dart';

class AppRoutes {
  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String settingsRoute = '/settings';
  static const String gameRoute = '/game';

  Route? onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    // final RouteParameters? parameters = settings.arguments as RouteParameters?;
    final Widget page;
    switch (name) {
      case gameRoute:
        page = const GamePage();
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
