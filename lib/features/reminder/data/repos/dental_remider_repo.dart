import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';

abstract class DentalRemiderRepo {
  Future<Either<Failure, DentalReminder>> addReminder(DentalReminder reminder);
  
  Future<Either<Failure,List<DentalReminder>>> getReminder();
  //   Future<void> markAsDone(String reminderId);
  // Future<void> updateReminderStatus(String reminderId, ReminderStatus status) ;
Future<Either<Failure, DentalReminder>> updateReminder(DentalReminder reminder) ;

}