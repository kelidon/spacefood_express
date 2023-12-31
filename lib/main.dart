import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeData _buildTheme() {
    var baseTheme = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true,);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.gruppoTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: '',
      theme: _buildTheme(),
      home: const GamePage(),
    );


  }
}
