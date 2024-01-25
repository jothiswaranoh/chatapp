import 'package:flutter/material.dart';

ThemeData darktMode = ThemeData(
  brightness: Brightness.dark, // Corrected to dark
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
    secondary: Color.fromARGB(255, 68, 178, 165),
    inversePrimary: Color.fromARGB(
        255, 44, 169, 194), // Use onPrimary instead of inversePrimary
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        displayColor: Colors.black,
        bodyColor: Colors.white,
      ),
);
