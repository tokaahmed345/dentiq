import 'package:bloc/bloc.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:dentiq/features/reminder/data/repos/dental_remider_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'dental_reminder_state.dart';

class DentalReminderCubit extends Cubit<DentalReminderState> {
  DentalReminderCubit(this.repo) : super(DentalReminderInitial());

  final DentalRemiderRepo repo;

  void fetchUpcomingReminders() async {
    emit(DentalReminderLoading());

    final result = await repo.getReminder();

    result.fold(
      (failure) => emit(DentalReminderFailure(failure.message)),
      (reminders) {
        final now = DateTime.now();

        final upcoming = reminders.where((r) {
          final time = r.reminderTime.toDate();
          return time.isAfter(now) &&
              r.status == ReminderStatus.pending;
        }).toList()
          ..sort(
            (a, b) =>
                a.reminderTime.compareTo(b.reminderTime),
          );

        emit(DentalReminderSuccess(upcoming));
      },
    );
  }
Future<void> addReminder(DentalReminder reminder) async {
  emit(DentalReminderLoading());

  final result = await repo.addReminder(reminder);

  result.fold(
    (failure) => emit(DentalReminderFailure(failure.message)),
    (savedReminder) async {
final uniqueId =
    DateTime.now().millisecondsSinceEpoch % 1000000000;
      final dateTime = savedReminder.reminderTime.toDate();

      debugPrint('📝 Adding reminder with ID $uniqueId at $dateTime');


     


      fetchUpcomingReminders();
    },
  );
}

}
