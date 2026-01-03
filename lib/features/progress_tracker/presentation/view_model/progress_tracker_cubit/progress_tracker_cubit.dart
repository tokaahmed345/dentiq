import 'package:bloc/bloc.dart';
import 'package:dentiq/features/progress_tracker/data/model/daily_progress_model.dart';
import 'package:dentiq/features/progress_tracker/data/repos/daily_progress_repo.dart';
import 'package:equatable/equatable.dart';

part 'progress_tracker_state.dart';

// class ProgressTrackerCubit extends Cubit<ProgressTrackerState> {
//   ProgressTrackerCubit(this.progress) : super(ProgressTrackerInitial());
//   final ProgressRepo progress;

//   Future<void> trackProgress() async {
//     emit(ProgressTrackerLoading());

//     final res = await progress.getTodayProgress();

//     res.fold(
//       (failure) => emit(ProgressTrackerFailure(errorMessage: failure.message)),
//       (dailyProgress) {
//         final overall = _calculateOverall(dailyProgress);
//         final message = _getMessage(overall);
//         final streak = dailyProgress.streak;

//         emit(ProgressTrackerSuccess(
//           dailyProgress: dailyProgress,
//           overallProgress: overall,
//           message: message,
//           streak: streak,
//         ));
//       },
//     );
//   }

//   double _calculateOverall(DailyProgressModel p) {
//     int done = [
//       p.morningBrushing,
//       p.flossing,
//       p.eveningBrushing,
//       p.mouthwash,
//     ].where((e) => e).length;
//     return done / 4;
//   }

//   String _getMessage(double progress) {
//     if (progress == 0) return "Let’s start your routine 💪";
//     if (progress < 1) return "Great job, keep going 👏";
//     return "Perfect day! 🦷✨";
//   }
// String routineFieldKey(String routine) {
//   switch (routine) {
//     case "Morning Brushing":
//       return "morningBrushing";
//     case "Evening Brushing":
//       return "eveningBrushing";
//     case "Flossing":
//       return "flossing";
//     case "Mouthwash":
//       return "mouthwash";
//     default:
//       return routine;
//   }
// }

//   Future<void> updateRoutine(String routine, bool value) async {
//   if (state is ProgressTrackerSuccess) {
//     final currentState = state as ProgressTrackerSuccess;
//     final dailyProgress = currentState.dailyProgress;

//     // تعديل الموديل محليًا
//     switch (routine) {
//       case "Morning Brushing":
//         dailyProgress.morningBrushing = value;
//         break;
//       case "Flossing":
//         dailyProgress.flossing = value;
//         break;
//       case "Evening Brushing":
//         dailyProgress.eveningBrushing = value;
//         break;
//       case "Mouthwash":
//         dailyProgress.mouthwash = value;
//         break;
//     }

//     // حدث الـ UI مباشرة
//     emit(ProgressTrackerSuccess(
//       dailyProgress: dailyProgress,
//       overallProgress: _calculateOverall(dailyProgress),
//       message: _getMessage(_calculateOverall(dailyProgress)),
//       streak: currentState.streak,
//     ));

//     // حدث Firestore بالـ camelCase
//     final fieldKey = routineFieldKey(routine);
//     final res = await progress.updateRoutine(fieldKey, value);
//     res.fold(
//       (failure) => emit(ProgressTrackerFailure(errorMessage: failure.message)),
//       (_) {},
//     );
//   }
// }

// }

class ProgressTrackerCubit extends Cubit<ProgressTrackerState> {
  ProgressTrackerCubit(this.progress) : super(ProgressTrackerInitial());

  final ProgressRepo progress;

  Future<void> trackProgress() async {
    emit(ProgressTrackerLoading());

    final res = await progress.getTodayProgress();

    res.fold(
      (failure) => emit(ProgressTrackerFailure(errorMessage: failure.message)),
      (dailyProgress) {
        final overall = _calculateOverall(dailyProgress);
        final message = _getMessage(overall);

        emit(ProgressTrackerSuccess(
          dailyProgress: dailyProgress,
          overallProgress: overall,
          message: message,
        ));
      },
    );
  }

  double _calculateOverall(DailyProgressModel p) {
    int done = [
      p.morningBrushing,
      p.flossing,
      p.eveningBrushing,
      p.mouthwash,
      p.checkGums,
      p.drinkWater,
      p.healthyMeals,
      p.tongueCleaning
    ].where((e) => e).length;
    return done / 8;
  }

  String _getMessage(double progress) {
    if (progress == 0) return "Let’s start your routine 💪";
    if (progress < 1) return "Great job, keep going 👏";
    return "Perfect day! 🦷✨";
  }

  String routineFieldKey(String routine) {
    switch (routine) {
      case "Morning Brushing":
        return "morningBrushing";
      case "Evening Brushing":
        return "eveningBrushing";
      case "Flossing":
        return "flossing";
      case "Mouthwash":
        return "mouthwash";
      default:
        return routine;
    }
  }

  Future<void> updateRoutine(String routine, bool value) async {
    if (state is ProgressTrackerSuccess) {
      final currentState = state as ProgressTrackerSuccess;
      final dailyProgress = currentState.dailyProgress;

     switch (routine) {
  case "Morning Brushing":
    dailyProgress.morningBrushing = value;
    break;
  case "Evening Brushing":
    dailyProgress.eveningBrushing = value;
    break;
  case "Flossing":
    dailyProgress.flossing = value;
    break;
  case "Mouthwash":
    dailyProgress.mouthwash = value;
    break;
  case "Drink Water":
    dailyProgress.drinkWater = value;
    break;
  case "Healthy Meals":
    dailyProgress.healthyMeals = value;
    break;
  case "Tongue Cleaning":
    dailyProgress.tongueCleaning = value;
    break;
  case "Check Gums":
    dailyProgress.checkGums = value;
    break;
}


      final resRoutine =
          await progress.updateRoutine(routineFieldKey(routine), value);
      resRoutine.fold(
        (failure) => emit(ProgressTrackerFailure(errorMessage: failure.message)),
        (_) {
          final overall = _calculateOverall(dailyProgress);

          emit(ProgressTrackerSuccess(
            dailyProgress: dailyProgress,
            overallProgress: overall,
            message: _getMessage(overall),
          ));
        },
      );
    }
  }
}
