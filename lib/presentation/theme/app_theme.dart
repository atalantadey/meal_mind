import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
