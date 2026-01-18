import 'package:dentiq/features/reminder/data/models/dental_reminder_type.dart';
import 'package:flutter/material.dart';

class Constant {
   static final List<DentalReminderType> reminderTypes = [
    DentalReminderType(
      title: "Morning Brushing",
      subtitle: "Start your day fresh",
      icon: Icons.wb_sunny_outlined,
    ),
    DentalReminderType(
      title: "Evening Brushing",
      subtitle: "Before going to bed",
      icon: Icons.nights_stay_outlined,
    ),
    DentalReminderType(
      title: "Flossing",
      subtitle: "Clean between teeth",
      icon: Icons.cleaning_services_outlined,
    ),
    DentalReminderType(
      title: "Mouthwash",
      subtitle: "Extra protection",
      icon: Icons.local_drink_outlined,
    ),
    DentalReminderType(
      title: "Change Toothbrush",
      subtitle: "Every 3 months",
      icon: Icons.autorenew_outlined,
    ),
    DentalReminderType(
      title: "Dental Scan",
      subtitle: "Check your teeth using scan",
      icon: Icons.camera_alt_outlined,
    ),
    DentalReminderType(
      title: "Whitening Routine",
      subtitle: "Keep your smile bright",
      icon: Icons.auto_awesome_outlined,
    ),
  ];

}