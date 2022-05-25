import 'package:flutter/material.dart';

class CustomThemeData {

  final ThemeData themeData;
  final Color tileColor;
  final Color mainTextColor;
  final BoxShadow tileShadow;

  CustomThemeData({
    required this.themeData,
    required this.tileColor,
    required this.mainTextColor,
    required this.tileShadow
  });
}