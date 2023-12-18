import 'package:flutter/material.dart';
import 'package:flutter_layer/common/routes/app_routes.dart';
import 'package:flutter_layer/common/theme/theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  static const AppRoutes _appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _appRoutes.onGenerateRoute,
      initialRoute: AppRoutes.homeRoute,
      theme: AppTheme.themeData,
    );
  }
}
