import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';

abstract class LogoutRepo {
   Future<Either<Failure, void >> logout();
}