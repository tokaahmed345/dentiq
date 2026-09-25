
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:dentiq/features/reminder/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';

class ReminderHistoryCard extends StatelessWidget {
  final DentalReminder reminder;
  final bool showDoneButton;
  final VoidCallback? onDone;

  const ReminderHistoryCard({
    super.key,
    required this.reminder,
    required this.showDoneButton,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final isMissed = reminder.status == ReminderStatus.missed;
    final color = isMissed ? Colors.red : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary!.withOpacity(0.85),
            AppColors.primary!.withOpacity(0.65),
            Colors.blue.shade300,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary!.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.25),
                child: Icon(
                  IconData(
                    int.tryParse(reminder.icon) ?? Icons.alarm.codePoint,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reminder.subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    Text(
                      reminder.time,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(reminder.status),
            ],
          ),
          if (showDoneButton) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onDone,
                icon: const Icon(Icons.check),
                label: const Text('Done'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
