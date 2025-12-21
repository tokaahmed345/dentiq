
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onNotificationTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),

        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.text20.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: AppStyle.text16.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          
          Container(
  width: 48,
  height: 48,
  decoration: const BoxDecoration(
    color: AppColors.whiteColor,
    shape: BoxShape.circle,
  ),
  child: Center(
    child: GestureDetector(
      onTap: onNotificationTap,
      child: Icon(
        Icons.notifications_outlined,
        size: 35,
        color: AppColors.primary,
      ),
    ),
  ),
),

        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
