import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/auth/data/model/log_in_model.dart';

abstract class LogInRepo {
  Future<Either<Failure,LogInModel>>login({  
  required String email,
  required String password,});
}