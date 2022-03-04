import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.black,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        shadowColor: Colors.white30,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        shadowColor: Colors.grey.shade100,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
