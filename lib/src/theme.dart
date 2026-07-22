import 'package:flutter/material.dart';

ThemeData buildVarshaTheme() {
  const orange = Color(0xFFE87722);
  const gray = Color(0xFF6B6B6B);
  const text = Color(0xFF1A1A1A);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: orange,
      primary: orange,
      secondary: gray,
      surface: const Color(0xFFFFFFFF),
      error: const Color(0xFFC62828),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    cardTheme: const CardThemeData(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    textTheme: Typography.blackMountainView.apply(
      bodyColor: text,
      displayColor: text,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: orange,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
