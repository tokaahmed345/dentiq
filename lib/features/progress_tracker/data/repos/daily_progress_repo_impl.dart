import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/core/utils/sharedprefrence.dart';
import '../model/daily_progress_model.dart';
import 'daily_progress_repo.dart';

// // class DailyProgressRepoImpl implements ProgressRepo {
// //   final FirebaseFirestore firestore = FirebaseFirestore.instance;

// //   String get today => DateTime.now().toIso8601String().split('T').first;

// //   @override
// //   Future<Either<Failure, DailyProgressModel>> getTodayProgress(String userId) async {
// //     try {
// //       final docRef = firestore
// //           .collection('users')
// //           .doc(userId)
// //           .collection('progress')
// //           .doc(today);

// //       final snapshot = await docRef.get();

// //       if (snapshot.exists) {
// //         return Right(DailyProgressModel.fromJson(snapshot.data()!));
// //       } else {
// //         // لو اليوم مش موجود نعمله default
// //         final defaultProgress = DailyProgressModel(
// //           morningBrushing: false,
// //           flossing: false,
// //           eveningBrushing: false,
// //           mouthwash: false,
// //         );
// //         await docRef.set(defaultProgress.toJson());
// //         return Right(defaultProgress);
// //       }
// //     } catch (e) {
// //       return Left(Failure( e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, void>> updateRoutine(String userId, String field, bool value) async {
// //     try {
// //       final docRef = firestore
// //           .collection('users')
// //           .doc(userId)
// //           .collection('progress')
// //           .doc(today);

// //       await docRef.update({field: value});
// //       return const Right(null);
// //     } catch (e) {
// //       return Left(Failure( e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<Failure, int>> updateStreak(String userId, bool perfectDay) async {
// //     try {
// //       final userDoc = firestore.collection('users').doc(userId);
// //       final snapshot = await userDoc.get();

// //       int currentStreak = snapshot.data()?['streak'] ?? 0;

// //       if (perfectDay) {
// //         currentStreak++;
// //         await userDoc.update({'streak': currentStreak});
// //       }

// //       return Right(currentStreak);
// //     } catch (e) {
// //       return Left(Failure( e.toString()));
// //     }
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dentiq/core/utils/sharedprefrence.dart';
// import 'package:dentiq/core/utils/failure/failure.dart';
// import '../model/daily_progress_model.dart';
// import 'daily_progress_repo.dart';

// class DailyProgressRepoImpl implements ProgressRepo {
//   final FirebaseFirestore firestore ;
// final SharedPrefs sharedPreferences;

//   DailyProgressRepoImpl({required this.firestore, required this.sharedPreferences, });
//   String get today => DateTime.now().toIso8601String().split('T').first;

 
//   @override
//   Future<Either<Failure, DailyProgressModel>> getTodayProgress() async {
//     try {
//       final id = await sharedPreferences.getUserId();
// print("UserId from SharedPrefs: $id");

//       final docRef = firestore
//           .collection('users')
//           .doc(id)
//           .collection('progress')
//           .doc(today);

//       final snapshot = await docRef.get();

//       if (snapshot.exists) {
//         return Right(DailyProgressModel.fromJson(snapshot.data()!));
//       } else {
//         final defaultProgress = DailyProgressModel(
//           morningBrushing: false,
//           flossing: false,
//           eveningBrushing: false,
//           mouthwash: false,
//         );
//         await docRef.set(defaultProgress.toJson());
//         return Right(defaultProgress);
//       }
//     } catch (e) {
//       return Left(Failure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> updateRoutine( String field, bool value) async {
//     try {
//       final id = await sharedPreferences.getUserId();

//       final docRef = firestore
//           .collection('users')
//           .doc(id)
//           .collection('progress')
//           .doc(today);

//       await docRef.update({field: value});
//       return const Right(null);
//     } catch (e) {
//       return Left(Failure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, int>> updateStreak( bool perfectDay) async {
//     try {
//       final id = await sharedPreferences.getUserId();

//       final userDoc = firestore.collection('users').doc(id);
//       final snapshot = await userDoc.get();

//       int currentStreak = snapshot.data()?['streak'] ?? 0;

//       if (perfectDay) {
//         currentStreak++;
//         await userDoc.update({'streak': currentStreak});
//       }

//       return Right(currentStreak);
//     } catch (e) {
//       return Left(Failure(e.toString()));
//     }
//   }
// }
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

//   @override
//   Future<Either<Failure, int>> incrementStreak() async {
//     try {
//       final id = await sharedPreferences.getUserId();
//       final userDoc = firestore.collection('users').doc(id);
//       final snapshot = await userDoc.get();

//       int currentStreak = snapshot.data()?['streak'] ?? 0;
//       currentStreak++; // نزود مرة واحدة عند اكتمال اليوم

// await userDoc.set({'streak': currentStreak}, SetOptions(merge: true));
//       return Right(currentStreak);
//     } catch (e) {
//       return Left(Failure(e.toString()));
//     }
//   }

//   @override
//   Stream<int> streakStream() async* {
//     final id = await sharedPreferences.getUserId();
//     final userDoc = firestore.collection('users').doc(id);

//     await for (final snapshot in userDoc.snapshots()) {
//       final streak = snapshot.data()?['streak'] ?? 0;
//       yield streak;
//     }
//   }
}