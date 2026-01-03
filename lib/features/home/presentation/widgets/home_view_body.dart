import 'package:dentiq/features/home/presentation/widgets/custom_carousel_slider.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_progress.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_reminder_list.dart';
import 'package:dentiq/features/progress_tracker/presentation/view_model/progress_tracker_cubit/progress_tracker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          const SizedBox(height: 10),
          CustomCarouselSlider(),
          const SizedBox(height: 20),
          CustomGridView(),
          const SizedBox(height: 20),

          BlocBuilder<ProgressTrackerCubit, ProgressTrackerState>(
            builder: (context, state) {
              if (state is ProgressTrackerSuccess) {
                return CustomProgress(
                  progress: state.overallProgress,
                  message: state.message,
                );
              }
              return const CustomProgress(
                progress: 0.0,
                message: "Loading...",
              );
            },
          ),

          const SizedBox(height: 20),
          CustomRemiderList(reminders: reminders),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
