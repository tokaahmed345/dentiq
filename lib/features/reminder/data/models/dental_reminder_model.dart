import 'package:cloud_firestore/cloud_firestore.dart';

enum ReminderStatus { pending, done, missed }

class DentalReminder {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final Timestamp reminderTime;
  final String icon;
  final ReminderStatus status;

  bool isNotified; 
  bool isRead;     

  DentalReminder({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.reminderTime,
    required this.icon,
    this.status = ReminderStatus.pending,
    this.isNotified = false,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'time': time,
        'reminderTime': reminderTime,
        'icon': icon,
        'status': status.index, // نخزن كـ int في Firestore
        // ملاحظة: isNotified و isRead لن نخزنهم في Firestore
      };

  factory DentalReminder.fromJson(Map<String, dynamic> json, String id) {
    return DentalReminder(
      id: id,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      time: json['time'] ?? '',
      reminderTime: json['reminderTime'] as Timestamp,
      icon: json['icon'] ?? '',
      status: ReminderStatus.values[json['status'] ?? 0],
      isNotified: false,
      isRead: false,
    );
  }

  DentalReminder copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? time,
    Timestamp? reminderTime,
    String? icon,
    ReminderStatus? status,
    bool? isNotified,
    bool? isRead,
  }) {
    return DentalReminder(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      reminderTime: reminderTime ?? this.reminderTime,
      icon: icon ?? this.icon,
      status: status ?? this.status,
      isNotified: isNotified ?? this.isNotified,
      isRead: isRead ?? this.isRead,
    );
  }
}
