import 'package:flutter/material.dart';

ThemeData darktMode = ThemeData(
  brightness: Brightness.dark, // Corrected to dark
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Color.fromARGB(255, 95, 180, 195),
    secondary: Color.fromARGB(255, 68, 178, 165),
    inversePrimary: Color.fromARGB(
        255, 44, 169, 194), // Use onPrimary instead of inversePrimary
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Color.fromARGB(255, 59, 184, 207),
        displayColor: Colors.black,
      ),
);
