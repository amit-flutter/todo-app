import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
  );
}
