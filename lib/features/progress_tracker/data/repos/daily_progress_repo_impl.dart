import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/core/utils/sharedprefrence.dart';
import '../model/daily_progress_model.dart';
import 'daily_progress_repo.dart';




class DailyProgressRepoImpl implements ProgressRepo {
  final FirebaseFirestore firestore;
  final SharedPrefs sharedPreferences;

  DailyProgressRepoImpl({required this.firestore, required this.sharedPreferences});

  String get today => DateTime.now().toIso8601String().split('T').first;

  @override
  Future<Either<Failure, DailyProgressModel>> getTodayProgress() async {
    try {
      final id = await sharedPreferences.getUserId();
      final docRef = firestore.collection('users').doc(id).collection('progress').doc(today);

      final snapshot = await docRef.get();
      if (snapshot.exists) {
        return Right(DailyProgressModel.fromJson(snapshot.data()!));
      } else {
        final defaultProgress = DailyProgressModel(
          morningBrushing: false,
          eveningBrushing: false,
          flossing: false,
          mouthwash: false,
        );
        await docRef.set(defaultProgress.toJson());
        return Right(defaultProgress);
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateRoutine(String field, bool value) async {
    try {
      final id = await sharedPreferences.getUserId();
      final docRef = firestore.collection('users').doc(id).collection('progress').doc(today);
      await docRef.update({field: value});
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

}