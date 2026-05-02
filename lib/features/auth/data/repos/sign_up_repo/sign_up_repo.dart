import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/auth/data/model/sign_up_model.dart';

abstract class SignUpRepo {
  Future<Either<Failure,SignUpModel>>register({  required String name,
  required String email,
  required String password,
  required String phone,
  required String gender,});
}