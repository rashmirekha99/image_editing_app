import 'package:flutter/material.dart';
import 'package:image_editing_app/core/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.mainColor),
      scaffoldBackgroundColor: Colors.white);
}
