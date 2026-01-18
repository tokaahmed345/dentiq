import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';

class CustomRemiderList extends StatelessWidget {
  const CustomRemiderList({
    super.key,
    required this.reminders,
  });

  final List<DentalReminder> reminders;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            " Upcoming Reminders",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...reminders.map((r) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.blue.shade50,
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconData(int.parse(r.icon), fontFamily: 'MaterialIcons'),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      r.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      r.time,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
