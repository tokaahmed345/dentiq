import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/core/utils/sharedprefrence.dart';
import 'package:dentiq/features/reminder/data/models/dental_reminder_model.dart';
import 'dental_remider_repo.dart';

class DentalReminderRepoImpl implements DentalRemiderRepo {
  final FirebaseFirestore firestore;
  final SharedPrefs sharedPreferences;

  DentalReminderRepoImpl({required this.firestore, required this.sharedPreferences});

  @override
  Future<Either<Failure, DentalReminder>> addReminder(DentalReminder reminder) async {
    try {
      final userId = await sharedPreferences.getUserId();
      final docRef = firestore.collection('users').doc(userId).collection('reminders').doc();
      final reminderWithId = reminder.copyWith(id: docRef.id);
      await docRef.set(reminderWithId.toJson());
      return Right(reminderWithId);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DentalReminder>>> getReminder() async {
    try {
      final userId = await sharedPreferences.getUserId();
      final querySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('reminders')
          .orderBy('reminderTime')
          .get();

      final reminders = querySnapshot.docs
          .map((doc) => DentalReminder.fromJson(doc.data(), doc.id))
          .toList();
      return Right(reminders);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
Future<Either<Failure, DentalReminder>> updateReminder(DentalReminder reminder) async {
  try {
    final userId = await sharedPreferences.getUserId();
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('reminders')
        .doc(reminder.id);

    await docRef.update(reminder.toJson()); 
    return Right(reminder);
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}

  // @override
  // Future<void> markAsDone(String reminderId) async {
  //   final userId = await sharedPreferences.getUserId();
  //   await firestore
  //       .collection('users')
  //       .doc(userId)
  //       .collection('reminders')
  //       .doc(reminderId)
  //       .update({'isDone': true});
  // }


}
