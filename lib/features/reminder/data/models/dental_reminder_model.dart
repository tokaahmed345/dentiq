import 'package:cloud_firestore/cloud_firestore.dart';

class DentalReminder {
  final String id;
  final String title;
  final String subtitle;

  final String time;

  final Timestamp reminderTime;

  final String icon;

  DentalReminder({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.reminderTime,
    required this.icon,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'time': time,
        'reminderTime': reminderTime,
        'icon': icon,
      };

  factory DentalReminder.fromJson(Map<String, dynamic> json) => DentalReminder(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        subtitle: json['subtitle'] ?? '',
        time: json['time'] ?? '',
        reminderTime: json['reminderTime'] as Timestamp,
        icon: json['icon'] ?? '',
      );

  DentalReminder copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? time,
    Timestamp? reminderTime,
    String? icon,
  }) {
    return DentalReminder(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      reminderTime: reminderTime ?? this.reminderTime,
      icon: icon ?? this.icon,
    );
  }
}
