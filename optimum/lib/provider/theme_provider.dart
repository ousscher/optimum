import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
class MyThemes{
  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    shadowColor: Color(0xFF3A3A3A),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    shadowColor: Colors.white,
  );
}