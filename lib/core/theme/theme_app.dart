import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData themeLight = ThemeData.light().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.withOpacity(0.2),
      filled: true,
      // contentPadding: const EdgeInsets.only(left: 10),
      border: InputBorder.none,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
            side: const BorderSide(color: Colors.black, width: 1.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            textStyle: const TextStyle(fontWeight: FontWeight.bold))),
  );
}
