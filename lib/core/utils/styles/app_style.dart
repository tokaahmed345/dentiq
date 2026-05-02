import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
   static final TextStyle _baseStyle = GoogleFonts.poppins(
        color: AppColors.whiteColor,

  );
   static final text20 = _baseStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 20,

  );

  static final text18 = _baseStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 18,

  );
    static final text16 = _baseStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,

  );
   static final text28 = _baseStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 28,

  );
}