import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/auth/data/repos/forgot_password_repo/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordRepoImpl extends ForgotPasswordRepo {
  final FirebaseAuth firebaseAuth;

  ForgotPasswordRepoImpl(this.firebaseAuth);

  @override
  Future<Either<Failure, void>> sendResetLink(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error'));
    }
  }
}
