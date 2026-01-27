import 'package:dentiq/features/progress_tracker/presentation/view_model/progress_tracker_cubit/progress_tracker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressViewBody extends StatelessWidget {
  const ProgressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgressTrackerCubit, ProgressTrackerState>(
      listener: (context, state) {
        if (state is ProgressTrackerSuccess) {
          if (state.message.contains("🎉")) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green.shade600,
                  duration: const Duration(seconds: 3),
                ),
              );
            });
          }
        } else if (state is ProgressTrackerFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        if (state is ProgressTrackerLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProgressTrackerFailure) {
          return Center(child: Text(state.errorMessage));
        } else if (state is ProgressTrackerSuccess) {
          final dailyProgress = state.dailyProgress;

          final routines = [
{"title":  "Morning Brushing","done": dailyProgress.morningBrushing},
{ "title": "Evening Brushing","done": dailyProgress.eveningBrushing},
{  "title":"Flossing" ,"done":dailyProgress.flossing} ,
{ "title":"Mouthwash","done": dailyProgress.mouthwash,},
{  "title":"Drink Water","done": dailyProgress.drinkWater}  ,
{"title":"Healthy Meals","done": dailyProgress.healthyMeals,
},
{"title"  :"Tongue Cleaning","done": dailyProgress.tongueCleaning},
{ "title" :"Check Gums","done": dailyProgress.checkGums,
}         
 ];


          final overallProgress = state.overallProgress;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue.shade50,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Routine Progress",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900)),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: overallProgress,
                          color: Colors.blue,
                          backgroundColor: Colors.blue.shade100,
                          minHeight: 14,
                        ),
                        const SizedBox(height: 8),
                        Text("${(overallProgress * 100).toInt()}% Completed",
                            style: TextStyle(color: Colors.blueGrey)),
                        const SizedBox(height: 8),
                        Text(state.message,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        // const SizedBox(height: 4),
                        // Text("Streak: ${state.streak} days",
                        //     style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: routines.length,
                    itemBuilder: (context, index) {
                      final entry = routines[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 3,
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry['title'] as String,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900)),
                              Checkbox(
                                value: entry['done'] as bool,
                                activeColor: Colors.blue,
                                onChanged: (checked) {
                                  context
                                      .read<ProgressTrackerCubit>()
                                      .updateRoutine(
                                          entry['title'] as String,
                                          checked ?? false);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
