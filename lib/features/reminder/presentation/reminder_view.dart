import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/reminder/presentation/widgets/reminder_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReminderView extends StatelessWidget {
  const ReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          arrowBack: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
                size: 27,
              )),
          title: "Reminders"),
      body: const ReminderViewBody(),
    );
  }
}
