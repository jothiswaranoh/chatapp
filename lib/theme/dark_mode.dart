import 'package:flutter/material.dart';

ThemeData darktMode = ThemeData(
  brightness: Brightness.dark, // Corrected to dark
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade600, // Use onPrimary instead of inversePrimary
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[300],
    displayColor: Colors.black,
  ),
);
