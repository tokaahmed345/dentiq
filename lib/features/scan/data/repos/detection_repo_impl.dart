
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/scan/data/model/model_failure.dart';
import 'package:dentiq/features/scan/data/model/model_service.dart';
import 'package:dentiq/features/scan/data/model/prediction_model.dart';
import 'package:dentiq/features/scan/data/repos/detection_repo.dart';

class DetectionRepositoryImpl implements DetectionRepository {
  final ModelService modelService;

  DetectionRepositoryImpl(this.modelService);

  @override
  Future<Either<Failure, PredictionModel>> detect(File imageFile) async {
    try {
      await modelService.initModel();

      final imageBytes = await imageFile.readAsBytes();

      final result = await modelService.runInference(imageBytes);

      return Right(result);
    } catch (e) {
      return Left(ModelFailure(e.toString()));
    }
  }
}
