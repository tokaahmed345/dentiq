part of 'progress_home_tracker_cubit.dart';

sealed class ProgressHomeTrackerState extends Equatable {
  const ProgressHomeTrackerState();

  @override
  List<Object> get props => [];
}

final class ProgressHomeTrackerInitial extends ProgressHomeTrackerState {}
class HomeProgressLoading extends ProgressHomeTrackerState {}

class HomeProgressSuccess extends ProgressHomeTrackerState {
  final double routineProgress;
  final double reminderProgress;
  final double overallProgress;
  final String message;
  final List<Task> tasks;

  HomeProgressSuccess({
    required this.routineProgress,
    required this.reminderProgress,
    required this.overallProgress,
    required this.message,
    required this.tasks,
  });

  @override
  List<Object> get props =>
      [routineProgress, reminderProgress, overallProgress, message, tasks];
}

class HomeProgressFailure extends ProgressHomeTrackerState {
  final String error;

  HomeProgressFailure(this.error);

  @override
  List<Object> get props => [error];
}
