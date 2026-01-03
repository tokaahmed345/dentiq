import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/progress_tracker/data/model/daily_progress_model.dart';

abstract class ProgressRepo {
  Future<Either<Failure, DailyProgressModel>> getTodayProgress();
  Future<Either<Failure, void>> updateRoutine( String field, bool value);
  //  Future<Either<Failure, int>> incrementStreak(); // زيادة streak عند اكتمال اليوم
  // Stream<int> streakStream(); // stream للاستماع للتغييرات

}
