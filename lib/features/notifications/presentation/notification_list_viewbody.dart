import 'package:dentiq/features/notifications/presentation/view_model/cubit/notification_cubit.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recent Notifications")),
      body: BlocBuilder<NotificationCubit, List<DentalReminder>>(
        builder: (context, notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "No recent notifications 🦷",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final reminder = notifications[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(
                      Icons.notifications,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  title: Text(
                    reminder.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  subtitle: Text(
                    reminder.subtitle,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  trailing:  Text(
                    reminder.time,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
