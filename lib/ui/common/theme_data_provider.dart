import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/theme_data.dart';

class ThemeDataProvider with ChangeNotifier {

  void toggleDarkMode() {
    switchMode();
    notifyListeners();
  }

  bool _isLightTheme = true;

  final _darkTheme = CustomThemeData(
      themeData: ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: const Color(0xFFD8ECF1),
        scaffoldBackgroundColor: const Color(0xFF2A2B2E),
      ),
      tileColor: const Color(0xff3e4145),
      mainTextColor: const Color(0xF5D9D9E5),
      tileShadow: const BoxShadow(
        color: Color.fromRGBO(65, 40, 0, 0.65),
        spreadRadius: 3.0,
        blurRadius: 8.0,
        offset: Offset(5.0, 5.0),
      )
  );

  final _lightTheme = CustomThemeData(
      themeData: ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: const Color(0xFFD8ECF1),
        scaffoldBackgroundColor: const Color(0xFFF3F5F7),
      ),
      tileColor: Colors.white,
      mainTextColor: Colors.black,
      tileShadow: const BoxShadow(
          color: Color.fromRGBO(246, 202, 189, 0.55),
          spreadRadius: 3.0,
          blurRadius: 8.0,
          offset: Offset(5.0, 5.0)
      )
  );

  void switchMode() => _isLightTheme = !_isLightTheme;

  CustomThemeData get themeData => _isLightTheme ? _lightTheme : _darkTheme;
}