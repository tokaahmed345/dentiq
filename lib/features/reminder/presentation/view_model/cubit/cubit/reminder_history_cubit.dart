import 'package:bloc/bloc.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:dentiq/features/reminder/data/repos/dental_remider_repo.dart';
import 'package:equatable/equatable.dart';

part 'reminder_history_state.dart';

class ReminderHistoryCubit extends Cubit<ReminderHistoryState> {
  ReminderHistoryCubit(this.repo) : super(ReminderHistoryInitial());
   final DentalRemiderRepo repo;
Future<void> fetchHistory() async {
  emit(ReminderHistoryLoading());

  final result = await repo.getReminder();

  await result.fold(
    (failure) async {
      emit(ReminderHistoryFailure(failure.message));
    },
    (reminders) async {
      final now = DateTime.now();

      for (var r in reminders) {
        final time = r.reminderTime.toDate();
        if (time.isBefore(now) && r.status == ReminderStatus.pending) {
          await repo.updateReminder(
            r.copyWith(status: ReminderStatus.missed),
          );
        }
      }
    },
  );

  final refreshedResult = await repo.getReminder();

  refreshedResult.fold(
    (failure) => emit(ReminderHistoryFailure(failure.message)),
    (reminders) {
      final missed =
          reminders.where((r) => r.status == ReminderStatus.missed).toList();
      final done =
          reminders.where((r) => r.status == ReminderStatus.done).toList();

      emit(ReminderHistorySuccess(
        missed: missed,
        done: done,
      ));
    },
  );
}

Future<void> markAsDone(DentalReminder reminder) async {
  await repo.updateReminder(
    reminder.copyWith(status: ReminderStatus.done),
  );

  await fetchHistory();

}


}
