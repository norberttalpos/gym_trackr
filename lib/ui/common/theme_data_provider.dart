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
        scaffoldBackgroundColor: const Color(0xFF00766B),
      ),
      tileColor: const Color(0xff3e4145),
      mainTextColor: const Color(0xF5D9D9E5),
      tileShadow: const BoxShadow(
          color: Color.fromRGBO(255, 77, 0, 0.5764705882352941),
          spreadRadius: 2.0,
          blurRadius: 3.0,
          offset: Offset(3.0, 3.0)
      )
  );

  final _lightTheme = CustomThemeData(
      themeData: ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: const Color(0xFFD8ECF1),
        scaffoldBackgroundColor: const Color(0xFF00B4A5),
      ),
      tileColor: const Color(0xffe3eaea),
      mainTextColor: Colors.black,
      tileShadow: const BoxShadow(
          color: Color.fromRGBO(255, 77, 0, 0.792156862745098),
          spreadRadius: 2.0,
          blurRadius: 3.0,
          offset: Offset(3.0, 3.0)
      )
  );

  void switchMode() => _isLightTheme = !_isLightTheme;

  CustomThemeData get themeData => _isLightTheme ? _lightTheme : _darkTheme;
}