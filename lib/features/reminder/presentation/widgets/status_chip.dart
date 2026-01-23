
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final ReminderStatus status;
  const StatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    late Color bgColor;
    late Color textColor;
    late String text;

    switch (status) {
      case ReminderStatus.missed:
        bgColor = AppColors.redColor.withOpacity(0.2);
        textColor = AppColors.redColor.shade700;
        text = 'Missed';
        break;
      case ReminderStatus.done:
        bgColor = AppColors.greenColor.withOpacity(0.2);
        textColor = AppColors.greenColor.shade800;
        text = 'Done';
        break;
      default:
        bgColor = Colors.orange.withOpacity(0.2);
        textColor = Colors.orange.shade800;
        text = 'Pending';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: textColor.withOpacity(0.5), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

