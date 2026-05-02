import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentiq/features/progress_tracker/data/model/daily_progress_model.dart';
import 'package:dentiq/features/progress_tracker/data/repos/daily_progress_repo.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:dentiq/features/reminder/data/repos/dental_remider_repo.dart';

part 'progress_home_tracker_state.dart';

/// حالة المهمة
enum TaskStatus { pending, done, missed }

/// مهمة يومية (Routine أو Reminder)
class Task {
  final String id;
  final String title;
  TaskStatus status;
  final bool isRoutine;

  Task({
    required this.id,
    required this.title,
    required this.status,
    required this.isRoutine,
  });
}

class ProgressHomeTrackerCubit extends Cubit<ProgressHomeTrackerState> {
  ProgressHomeTrackerCubit(this.progressRepo, this.reminderRepo)
      : super(ProgressHomeTrackerInitial());

  final ProgressRepo progressRepo;
  final DentalRemiderRepo reminderRepo;

  Future<void> loadHomeProgress() async {
    emit(HomeProgressLoading());

    try {
      /// -----------------------------
      /// 1️⃣ Load Daily Routine Progress
      /// -----------------------------
      final routineResult = await progressRepo.getTodayProgress();
      DailyProgressModel? dailyProgress;

      routineResult.fold(
        (failure) => emit(HomeProgressFailure(failure.message)),
        (data) => dailyProgress = data,
      );

      /// -----------------------------
      /// 2️⃣ Load Reminders
      /// -----------------------------
      final remindersResult = await reminderRepo.getReminder();

      remindersResult.fold(
        (failure) => emit(HomeProgressFailure(failure.message)),
        (reminders) {
          final now = DateTime.now();

          final todayReminders = reminders.where((r) {
            final d = r.reminderTime.toDate();
            return d.year == now.year &&
                d.month == now.month &&
                d.day == now.day;
          }).toList();

          /// -----------------------------
          /// 3️⃣ Build Today Tasks
          /// -----------------------------
          final List<Task> todayTasks = [];

          /// ➕ Routines
          if (dailyProgress != null) {
            todayTasks.addAll([
              _routineTask("morningBrushing", "Morning Brushing",
                  dailyProgress!.morningBrushing),
              _routineTask("eveningBrushing", "Evening Brushing",
                  dailyProgress!.eveningBrushing),
              _routineTask(
                  "flossing", "Flossing", dailyProgress!.flossing),
              _routineTask(
                  "mouthwash", "Mouthwash", dailyProgress!.mouthwash),
              _routineTask(
                  "checkGums", "Check Gums", dailyProgress!.checkGums),
              _routineTask(
                  "drinkWater", "Drink Water", dailyProgress!.drinkWater),
              _routineTask("healthyMeals", "Healthy Meals",
                  dailyProgress!.healthyMeals),
              _routineTask("tongueCleaning", "Tongue Cleaning",
                  dailyProgress!.tongueCleaning),
            ]);
          }

          /// ➕ Reminders (Dynamic + Missed logic)
          for (final r in todayReminders) {
            final reminderTime = r.reminderTime.toDate();
            final isPast = reminderTime.isBefore(now);

            TaskStatus status;

            if (r.status == ReminderStatus.done) {
              status = TaskStatus.done;
            } else if (isPast) {
              status = TaskStatus.missed;
            } else {
              status = TaskStatus.pending;
            }

            todayTasks.add(Task(
              id: r.id,
              title: r.title,
              status: status,
              isRoutine: false,
            ));
          }

          /// -----------------------------
          /// 4️⃣ Calculate Progress
          /// -----------------------------
          final totalTasks = todayTasks.length;
          final doneTasks =
              todayTasks.where((t) => t.status == TaskStatus.done).length;

          final overallProgress =
              totalTasks == 0 ? 0.0 : doneTasks / totalTasks;

          final routineTasks =
              todayTasks.where((t) => t.isRoutine).toList();
          final routineDone =
              routineTasks.isEmpty
                  ? 0.0
                  : routineTasks
                          .where((t) => t.status == TaskStatus.done)
                          .length /
                      routineTasks.length;

          final reminderTasks =
              todayTasks.where((t) => !t.isRoutine).toList();
          final reminderDone =
              reminderTasks.isEmpty
                  ? 0.0
                  : reminderTasks
                          .where((t) => t.status == TaskStatus.done)
                          .length /
                      reminderTasks.length;

          /// -----------------------------
          /// 5️⃣ Emit Success
          /// -----------------------------
          emit(HomeProgressSuccess(
            routineProgress: routineDone,
            reminderProgress: reminderDone,
            overallProgress: overallProgress,
            tasks: todayTasks,
            message: _getMessage(overallProgress),
          ));
        },
      );
    } catch (e) {
      emit(HomeProgressFailure(e.toString()));
    }
  }

  /// -----------------------------
  /// Helpers
  /// -----------------------------
  Task _routineTask(String id, String title, bool isDone) {
    return Task(
      id: id,
      title: title,
      status: isDone ? TaskStatus.done : TaskStatus.pending,
      isRoutine: true,
    );
  }

  String _getMessage(double progress) {
    if (progress == 0) {
      return "Let’s start your day strong 💪";
    } else if (progress < 0.4) {
      return "You can still catch up 🌱";
    } else if (progress < 0.8) {
      return "Great job! Keep going 👏";
    } else {
      return "Amazing! You're crushing it 🦷✨";
    }
  }
}
