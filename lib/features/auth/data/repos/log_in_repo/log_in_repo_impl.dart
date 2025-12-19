import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/auth/data/model/log_in_model.dart';
import 'package:dentiq/features/auth/data/repos/log_in_repo/log_in_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInRepoImpl extends LogInRepo {
  final FirebaseAuth firebaseAuth;

  LogInRepoImpl({
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, LogInModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = LogInModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
      );

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
