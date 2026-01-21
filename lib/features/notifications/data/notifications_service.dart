import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: androidSettings);

    await notifications.initialize(settings);

    const AndroidNotificationChannel channel =
        AndroidNotificationChannel(
      'reminder_channel',
      'Reminders',
      description: 'Reminder notifications',
      importance: Importance.max,
      
    );

    await notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    debugPrint('✅ Timezone set to Africa/Cairo');
  }

  static Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      final result = await Permission.notification.request();
      debugPrint('Notification permission result: $result');
    } else {
      debugPrint('Notification permission already granted');
    }
  }
  

 static Future<void> scheduleReminder({
  required int id,
  required String title,
  required String body,
  required DateTime dateTime,
}) async {
  final now = tz.TZDateTime.now(tz.local);
  final scheduled = tz.TZDateTime.from(dateTime, tz.local);

  debugPrint('⏰ Now: $now');
  debugPrint('⏰ Scheduled: $scheduled');

  if (scheduled.isBefore(now)) {
    debugPrint('❌ Time already passed');
    return;
  }

  await notifications.zonedSchedule(
    id,
    title,
    body,
    scheduled,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}


  static Future<void> cancelReminder(int id) async {
    await notifications.cancel(id);
  }

  static Future<void> testNotification() async {
    await notifications.show(
      111,
      'Test',
      'Notification works 🔥',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
