
import 'package:dentiq/features/home/presentation/widgets/custom_carousel_slider.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_progress.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_reminder_list.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
const HomeViewBody({super.key});

  final List<Map<String, String>> reminders = const [
    {"title": "Morning Brushing", "time": "08:00 AM"},
    {"title": "Flossing", "time": "08:30 AM"},
    {"title": "Evening Brushing", "time": "08:00 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
CustomCarouselSlider(),

          SizedBox(height: 20),

        
CustomGridView(),
          SizedBox(height: 20),

          CustomProgress(),

          SizedBox(height: 20),

          CustomRemiderList(reminders: reminders),

          SizedBox(height: 30),
        ],
      ),
    );
  }


}

