import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.blue[50],
        colorScheme: ColorScheme.light(
          primary: Colors.blue[900]!,
onPrimary: AppColors.blueGrey!.withOpacity(.5),
          surface: Colors.white,
          onSurface: const Color(0xff003851),
        ),
        useMaterial3: true,
        cardColor:  const Color(0xff003851),

      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff020617),
        colorScheme: const ColorScheme.dark(
          primary:  Color(0xffE8EAF0),
          surface: Color(0xff0D1B2A),
          onSurface: Color(0xffE8EAF0),
          onPrimary:Colors.grey
          ,

        ),
        cardColor:  const Color(0xff003851),
      
        useMaterial3: true,
      );
}