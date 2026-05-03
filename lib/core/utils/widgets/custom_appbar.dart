
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/tips/presentation/widgets/articles_details.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onNotificationTap,
    this.bottom,
    this.suffixIcon, this.arrowBack, this.suffixIconWidget,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onNotificationTap;
  final PreferredSizeWidget? bottom;
final IconData ?suffixIcon;
final Widget ?arrowBack;
final Widget? suffixIconWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading:arrowBack??null ,
      backgroundColor: AppColors.primary,
      toolbarHeight: 80,
      bottom: bottom,
      automaticallyImplyLeading: false,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppStyle.text20.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: AppStyle.text16.copyWith(
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          ),
          if (onNotificationTap != null)
            GestureDetector(
              onTap: onNotificationTap,
              child: Container(
                width: 44,
                height: 44,
                decoration:  BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: suffixIconWidget ?? Icon(suffixIcon, color: AppColors.primary),

              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? 80 : 140);
}
