import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light, // Explicitly set brightness to light
  colorScheme: ColorScheme.light(
    onPrimary: Color.fromARGB(248, 176, 250, 247),
    background: Colors.white,
    primary: Color.fromARGB(140, 1, 3, 3),
    secondary: Color.fromARGB(255, 30, 77, 100),
    inversePrimary: Color.fromARGB(255, 44, 169, 194),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
);
