import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataProvider with ChangeNotifier {

  late bool _isLightTheme;

  static const String _isLightThemeKey = "isLightTheme";

  ThemeDataProvider() {
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPref = prefs.getBool(_isLightThemeKey);

    if(savedPref == null) {
      prefs.setBool(_isLightThemeKey, true);
      _isLightTheme = true;
    } else {
      _isLightTheme = prefs.getBool(_isLightThemeKey)!;
    }
  }

  void toggleDarkMode() {
    _switchMode();
    notifyListeners();
  }

  bool get isLightTheme => _isLightTheme;

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
      mainTextColor: const Color(0xff222222),
      tileShadow: const BoxShadow(
          color: Color.fromRGBO(255, 77, 0, 0.792156862745098),
          spreadRadius: 2.0,
          blurRadius: 3.0,
          offset: Offset(3.0, 3.0)
      )
  );

  void _switchMode() async {
    _isLightTheme = !_isLightTheme;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLightThemeKey, _isLightTheme);
  }

  CustomThemeData get themeData => _isLightTheme ? _lightTheme : _darkTheme;

  CustomThemeData get oppositeThemeData => _isLightTheme ? _darkTheme : _lightTheme;
}