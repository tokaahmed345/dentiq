import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';

abstract class ForgotPasswordRepo {
  Future<Either<Failure, void>> sendResetLink(String email);
}
