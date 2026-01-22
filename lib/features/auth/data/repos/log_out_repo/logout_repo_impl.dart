
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/auth/data/repos/log_out_repo/logout_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutRepoImpl extends LogoutRepo {
  final FirebaseAuth firebaseAuth;

  LogoutRepoImpl({required this.firebaseAuth});

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null); 
    } catch (e) {
      return Left(Failure(e.toString())); 
    }
  }
}