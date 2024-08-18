import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/core/themes/app_color.dart';

class DarkTheme {
  static ThemeData setDarkMode() => ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: AppColors.primaryColor,
            systemNavigationBarColor: AppColors.deepBlue,
          ),
        ),
        scaffoldBackgroundColor: AppColors.drak,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primaryColor,
        ),
      );
}
