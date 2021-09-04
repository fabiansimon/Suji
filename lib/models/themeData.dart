import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor:
          isDarkTheme ? const Color(0xFF2B2B2B) : const Color(0xFF0496FF),
      focusColor: isDarkTheme
          ? const Color(0xFF1D1D1D)
          : const Color(0xFF076BBE), //pimaryColorAccent
      accentColor:
          isDarkTheme ? const Color(0xFFEF4B6B) : const Color(0xFFD81159),
      indicatorColor: isDarkTheme
          ? const Color(0xFFEA5471)
          : const Color(0xFFFF2976), //accentColorAccent
      backgroundColor:
          isDarkTheme ? const Color(0xFF161515) : const Color(0xFFF6F6F6),
      cardColor:
          isDarkTheme ? const Color(0xFF2C2C2C) : const Color(0xFFFFFFFF),
      hintColor: isDarkTheme
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF131415), //text black
      highlightColor: isDarkTheme
          ? const Color(0xFF9C9C9C)
          : const Color(0xFF878787), //subtle text color
    );
  }
}
