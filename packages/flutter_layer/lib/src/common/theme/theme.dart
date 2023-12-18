import 'package:flutter/material.dart';
import 'package:flutter_layer/src/common/theme/text_theme.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
    ),
  );
}
