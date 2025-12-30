import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/reminder/presentation/widgets/reminder_view_body.dart';
import 'package:flutter/material.dart';

class ReminderView extends StatelessWidget {
  const ReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reminders",),
      body: ReminderViewBody(),);
  }
}