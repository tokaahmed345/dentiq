import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [
                  AppColors.darkBlue,
                  AppColors.secondary,
                ],
              ),
            ),
            child: Center(
              child: Text(
                'Capture & Scan Now',
                style: AppStyle.text16.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload),
            label: const Text('Upload from Gallery'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
