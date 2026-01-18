import 'package:bloc/bloc.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:dentiq/features/reminder/data/repos/dental_remider_repo.dart';
import 'package:equatable/equatable.dart';

part 'dental_reminder_state.dart';

class DentalReminderCubit extends Cubit<DentalReminderState> {
  DentalReminderCubit(this.repo) : super(DentalReminderInitial());
    final DentalRemiderRepo repo;
  void fetchReminders() async {
    emit(DentalReminderLoading());
    final result = await repo.getReminder();
    result.fold(
      (failure) => emit(DentalReminderFailure(failure.message)),
      (reminders) => emit(DentalReminderSuccess(reminders)),
    );
  }

  Future<void> addReminder(DentalReminder reminder) async {
  emit(DentalReminderLoading());
  final result = await repo.addReminder(reminder);
  result.fold(
    (failure) => emit(DentalReminderFailure(failure.message)),
    (_) => fetchReminders(),
  );
}

}
