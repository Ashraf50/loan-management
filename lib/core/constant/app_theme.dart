import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkTheme;
  ThemeProvider({required this.isDarkTheme});
  ThemeData get getThemeData => isDarkTheme ? darkTheme : lightTheme;

  saveProperty(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('boolValue', value);
  }

  set setThemeData(bool val) {
    if (val) {
      isDarkTheme = true;
    } else {
      isDarkTheme = false;
    }
    saveProperty(isDarkTheme);
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primaryColor: const Color(0xff240F4F),
  brightness: Brightness.dark,
  hintColor: Colors.white,
  scaffoldBackgroundColor: const Color(0xff1e1e1e),
  dividerColor: const Color(0xff240F4F),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xff240F4F),
  ),
);

final lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  hintColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  dividerColor: Colors.white54,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFE5E5E5),
  ),
);
