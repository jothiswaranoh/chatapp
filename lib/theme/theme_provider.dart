import 'package:flutter/material.dart';
import 'package:groupchat/theme/light_mode.dart';
import 'package:groupchat/theme/dark_mode.dart';


class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = (_themeData == lightMode) ? darktMode : lightMode;
    notifyListeners();
  }
}
