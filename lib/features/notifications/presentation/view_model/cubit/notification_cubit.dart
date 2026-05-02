import 'package:bloc/bloc.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';
class NotificationCubit extends Cubit<List<DentalReminder>> {
  NotificationCubit() : super([]);

  void addNotification(DentalReminder reminder) {
    if (!state.any((r) => r.id == reminder.id)) {
      emit([...state, reminder]);
    }
  }

  void markAllAsRead() {
    emit(state.map((r) => r..isRead = true).toList());
  }

  int getUnreadCount() {
    return state.where((r) => r.isNotified && !r.isRead).length;
  }
}
