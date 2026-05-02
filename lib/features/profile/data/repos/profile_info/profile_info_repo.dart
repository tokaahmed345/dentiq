import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/auth/data/model/sign_up_model.dart';

abstract class ProfileInfoRepo {
Future<  Either <Failure,SignUpModel>> getProfileData();

  Future<Either <Failure,void>> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
        required String oldPassword, 

  });
}
