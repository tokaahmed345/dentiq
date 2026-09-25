import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/scan/data/model/diseases_model.dart';


abstract class DiseaseRepo {
  Future<Either<Failure, DiseaseModel>> getDiseaseById(String diseaseId);
}
