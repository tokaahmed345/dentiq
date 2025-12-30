
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: AppColors.primary!.withOpacity(.6),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.whiteColor)),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.6,
                color: AppColors.primary,
                backgroundColor: AppColors.whiteColor.withOpacity(.7),
                minHeight: 10,
              ),
              SizedBox(height: 5),
              Text("60% Completed", style: TextStyle(color: AppColors.whiteColor)),
            ],
          ),
        ),
      ),
    );
  }
}
