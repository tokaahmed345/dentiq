
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class NumberCircle extends StatelessWidget {
  final int number;

  const NumberCircle({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: AppColors.primary!.withOpacity(.4),
      child: Text(
        number.toString(),
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
