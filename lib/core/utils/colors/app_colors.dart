
// import 'package:flutter/material.dart';

// abstract  class AppColors {
// static const Color whiteColor = Colors.white;
// static const Color blackColor=Colors.black;
// static const darkBlue=Color(0xff003851);
// static const secondary= Color(0xFF0A1E3F);
// static Color? primary=Colors.blue[900];
//  static Color? blueGrey=  Colors.blueGrey[800];
//  static Color grey=  Colors.grey;

// static const redColor= Colors.red;
// static const blueColor= Colors.blue;
// static const transparent= Colors.transparent;



//   static const Color primaryDark = Color(0xff020617);

//   static const Color lightBackground = Color(0xffF6F7FB);
//   static const Color tipsBackground = Color(0xffEEF2FF);

//   static const  greenColor = Colors.green;
// }

import 'package:flutter/material.dart';

abstract class AppColors {
  // ── ثابتة مش بتتغير ──
  static const  redColor = Colors.red;
  
  static const Color blueColor = Colors.blue;
  static const Color transparent = Colors.transparent;
  static const  greenColor = Colors.green;
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const darkBlue = Color(0xff003851);
  static const secondary = Color(0xFF0A1E3F);
  static Color? primary = Colors.blue[900];
  static Color? blueGrey = Colors.blueGrey[800];
  static Color grey = Colors.grey;
  static const Color primaryDark = Color(0xff020617);
  static const Color lightBackground = Color(0xffF6F7FB);
  static const Color tipsBackground = Color(0xffEEF2FF);
}

extension AppColorsExtension on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  Color get backgroundColor =>
      _isDark ? const Color(0xff020617) : const Color(0xffF6F7FB);

  Color get surfaceColor =>
      _isDark ? const Color(0xff0D1B2A) : Colors.white;

  Color get primaryTextColor =>
      _isDark ? const Color(0xffE8EAF0) : const Color(0xff003851);

  Color get secondaryColor =>
      _isDark ? const Color(0xff1A3A5C) : const Color(0xFF0A1E3F);

  Color get primaryColor =>
      _isDark ? Colors.blue[300]! : Colors.blue[900]!;

  Color get blueGreyColor =>
      _isDark ? Colors.blueGrey[300]! : Colors.blueGrey[800]!;

  Color get greyColor =>
      _isDark ? Colors.grey[400]! : Colors.grey;

  Color get tipsBackgroundColor =>
      _isDark ? const Color(0xff1A1F3A) : const Color(0xffEEF2FF);
}