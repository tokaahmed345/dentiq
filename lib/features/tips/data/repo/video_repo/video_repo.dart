import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/tips/data/models/video_model.dart';

abstract class VideoRepo {
  Future<Either<Failure,List<VideoModel>>>getAllVideos();
}