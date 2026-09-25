part of 'progress_tracker_cubit.dart';

sealed class ProgressTrackerState extends Equatable {
  const ProgressTrackerState();

  @override
  List<Object> get props => [];
}

final class ProgressTrackerInitial extends ProgressTrackerState {}
final class ProgressTrackerLoading extends ProgressTrackerState {}
final class ProgressTrackerSuccess extends ProgressTrackerState {
  final DailyProgressModel dailyProgress;
  final double overallProgress; 
  final String message;

  const ProgressTrackerSuccess({
    required this.dailyProgress,
    required this.overallProgress,
    required this.message,
  });

  @override
  List<Object> get props => [dailyProgress, overallProgress, message,];
}

final class ProgressTrackerFailure extends ProgressTrackerState {
  final String errorMessage;

  const ProgressTrackerFailure({required this.errorMessage});
    @override
  List<Object> get props => [errorMessage];
}
