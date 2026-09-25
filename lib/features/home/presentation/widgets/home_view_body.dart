import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/home/presentation/view_model/cubit/progress_home_tracker_cubit.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_carousel_slider.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_progress.dart';
import 'package:dentiq/features/home/presentation/widgets/custom_reminder_list.dart';
import 'package:dentiq/features/progress_tracker/presentation/view_model/progress_tracker_cubit/progress_tracker_cubit.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/cubit/reminder_history_cubit.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/dental_reminder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MultiBlocListener(
        listeners: [
          BlocListener<DentalReminderCubit, DentalReminderState>(
            listener: (context, state) {
              if (state is DentalReminderSuccess) {
                for (var reminder in state.reminders) {}
                 context
              .read<ProgressHomeTrackerCubit>()
              .loadHomeProgress();
              }
            },
          ),
            BlocListener<ProgressTrackerCubit, ProgressTrackerState>(
      listener: (context, state) {
        if (state is ProgressTrackerSuccess) {
          context
              .read<ProgressHomeTrackerCubit>()
              .loadHomeProgress();
        }
      },
    ),

    BlocListener<ReminderHistoryCubit, ReminderHistoryState>(
      listener: (context, state) {
        if (state is ReminderHistorySuccess) {
          context
              .read<ProgressHomeTrackerCubit>()
              .loadHomeProgress();

        }
      },
    ),
        ],
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          CustomCarouselSlider(),
          const SizedBox(height: 20),
          CustomGridView(),
          const SizedBox(height: 20),
          BlocBuilder<ProgressHomeTrackerCubit, ProgressHomeTrackerState>(
            builder: (context, state) {
              if (state is HomeProgressSuccess) {
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
          BlocBuilder<DentalReminderCubit, DentalReminderState>(
            builder: (context, state) {
              if (state is DentalReminderLoading) {
                return  _buildReminderShimmerList();
              }

              if (state is DentalReminderSuccess) {
                final upcomingReminders = state.reminders
                    .where((r) => r.status != ReminderStatus.missed)
                    .take(7)
                    .toList();

                if (upcomingReminders.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          "  Upcoming Reminders",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "All caught up today 🦷✨",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return CustomRemiderList(
                  reminders: upcomingReminders,
                );
              }

              if (state is DentalReminderFailure) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("Error: //${state.message}"),
                );
              }

              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
  Widget _buildReminderShimmerList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "Upcoming Reminders",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 10),

      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
  baseColor: AppColors.primary!.withOpacity(0.2),
  highlightColor: AppColors.primary!.withOpacity(0.1),
  period: const Duration(milliseconds: 1200), 
  direction: ShimmerDirection.ltr, 
  child: _buildReminderShimmerCard(),
);
        },
      ),
    ],
  );
}
Widget _buildReminderShimmerCard() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.blue.shade50, 
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary!.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary!.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
          ),
        ),

        title: Container(
          height: 16,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primary!.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6),
          ),
        ),

        trailing: Container(
          height: 14,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.primary!.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    ),
  );
}
}
