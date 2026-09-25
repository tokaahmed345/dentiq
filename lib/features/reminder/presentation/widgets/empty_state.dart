
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  final IconData icon;

  const EmptyState({super.key, 
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: AppColors.grey),
          const SizedBox(height: 12),
          Text(
            text,
            style:  TextStyle(fontSize: 16, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
