import 'package:flutter/material.dart';
import 'package:oasis_flutter/config/color_config.dart';

class AppTheme {
  static const primaryColor = Color.fromARGB(255, 106, 49, 185);

  static ColorScheme fromBrightness({required Brightness brightness}) {
    return ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: primaryColor,
      // Customisation goes here
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightness(
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightness(
        brightness: Brightness.dark,
      ),
      primaryColorDark: ColorConfig.colorPrimary,
      primaryColor: ColorConfig.colorPrimary,
    );
  }
}
