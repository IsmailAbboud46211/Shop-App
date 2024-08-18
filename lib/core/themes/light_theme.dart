import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/core/themes/app_color.dart';

class LightTheme {
  static ThemeData setLightMode() =>
      ThemeData.light(useMaterial3: true).copyWith(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: AppColors.primaryColor,
            systemNavigationBarColor: AppColors.deepBlue,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
        ),
      );
}
