import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/scan/data/model/prediction_model.dart';

abstract class DetectionRepository {
  Future<Either<Failure, PredictionModel>> detect(File image);
}
