import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.blue[50],
        colorScheme: ColorScheme.light(
          primary: Colors.blue[900]!,

          surface: Colors.blue[50]!,
          onSurface: const Color(0xff003851),
        ),
        useMaterial3: true,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff020617),
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[300]!,
          surface: const Color(0xff0D1B2A),
          onSurface: const Color(0xffE8EAF0),
        ),
        cardColor:Colors.blue[900],
        useMaterial3: true,
      );
}