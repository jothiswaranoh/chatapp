import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light, // Explicitly set brightness to light
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Color.fromARGB(255, 82, 194, 194),
    secondary: Color.fromARGB(255, 30, 77, 100),
    inversePrimary: Color.fromARGB(
        255, 41, 44, 44), // Use onPrimary instead of inversePrimary
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Color.fromARGB(255, 12, 108, 114),
        displayColor: Colors.black,
      ),
);
