part of 'dental_reminder_cubit.dart';

sealed class DentalReminderState extends Equatable {
  const DentalReminderState();

  @override
  List<Object> get props => [];
}

final class DentalReminderInitial extends DentalReminderState {}
class DentalReminderLoading extends DentalReminderState {}

class DentalReminderSuccess extends DentalReminderState {
  final List<DentalReminder> reminders;
  const DentalReminderSuccess(this.reminders);
  
  @override
  List<Object> get props => [reminders];
}

class DentalReminderFailure extends DentalReminderState {
  final String message;
  const DentalReminderFailure(this.message);
  
  @override
  List<Object> get props => [message];
}