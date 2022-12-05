import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Colors.indigo;
  static final ThemeData themeDataLight = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
    ),
  );
}
