part of 'reminder_history_cubit.dart';

sealed class ReminderHistoryState extends Equatable {
  const ReminderHistoryState();

  @override
  List<Object> get props => [];
}

final class ReminderHistoryInitial extends ReminderHistoryState {}
class ReminderHistoryLoading extends ReminderHistoryState {}

class ReminderHistoryFailure extends ReminderHistoryState {
  final String message;
  ReminderHistoryFailure(this.message);
}

class ReminderHistorySuccess extends ReminderHistoryState {
  final List<DentalReminder> missed;
  final List<DentalReminder> done;

  ReminderHistorySuccess({required this.missed, required this.done});

  @override
  List<Object> get props => [missed, done];
}