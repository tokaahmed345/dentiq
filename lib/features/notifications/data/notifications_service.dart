// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter/material.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notifications =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initSettings = InitializationSettings(android: androidSettings);

//     await _notifications.initialize(
//       settings:  initSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         print('Notification clicked: ${response.payload}');
//       },
//     );

//     final androidImplementation = _notifications
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();
//     if (androidImplementation != null) {
//       await androidImplementation.requestNotificationsPermission();
//     }
//   }

//   /// تحسب الوقت القادم للـ reminder (صباح/ليل) بحيث لو الوقت عدّى يبدأ من بكرة
//   static tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
//     final now = tz.TZDateTime.now(tz.local);

//     var scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );

//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }

//     return scheduledDate;
//   }

//   /// دالة تسجل Notification يومي
//   static Future<void> scheduleDailyNotification({
//     required int id,
//     required String title,
//     required String body,
//     required TimeOfDay time,
//   }) async {
//     final scheduledDate = _nextInstanceOfTime(time);

//     const androidDetails = AndroidNotificationDetails(
//       'dental_channel',
//       'Dental Reminders',
//       channelDescription: 'Daily dental care reminders',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//    await _notifications.zonedSchedule(
//   id: id,
//   title: title,
//   body: body,
//   scheduledDate: scheduledDate,
//   notificationDetails: const NotificationDetails(android: androidDetails),
//   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//   matchDateTimeComponents: DateTimeComponents.time, // مهم للتكرار اليومي
// );
//   }
// }
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = IOSInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notifications.initialize
    (
     settings:  initSettings,
        onDidReceiveNotificationResponse: (response) {
      print('Notification clicked: ${response.payload}');
    });
  }

  static Future<void> showTestNotification({int secondsFromNow = 60}) async {
    final scheduledDate = tz.TZDateTime.now(tz.local).add(Duration(seconds: secondsFromNow));

    final channelId = 'dental_channel_${DateTime.now().millisecondsSinceEpoch}';
    final androidDetails = AndroidNotificationDetails(
      channelId,
      'Daily Reminders',
      channelDescription: 'Daily dental care reminders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    final androidImplementation =
        _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      final androidChannel = AndroidNotificationChannel(
        channelId,
        'Daily Reminders',
        description: 'Daily dental care reminders',
        importance: Importance.max,
        playSound: true,
      );
      await androidImplementation.createNotificationChannel(androidChannel);
    }

    await _notifications.zonedSchedule(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Test Notification',
      body: 'This is a test notification after $secondsFromNow seconds',
      scheduledDate: scheduledDate,
      notificationDetails: NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print('✅ Notification scheduled successfully!');
  }
}