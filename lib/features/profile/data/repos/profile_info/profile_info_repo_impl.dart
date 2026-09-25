import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/auth/data/model/sign_up_model.dart';
import 'package:dentiq/features/profile/data/repos/profile_info/profile_info_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepoImpl extends ProfileInfoRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  ProfileRepoImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

@override
Future<Either<Failure, SignUpModel>> getProfileData() async {
  try {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      return Left(Failure('User not logged in'));
    }

    final doc =
        await firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      return Left(Failure('User data not found'));
    }

    final model = SignUpModel.fromMap(doc.data()!);
    return Right(model);
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}
  Future<Either<Failure, void>> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
    required String oldPassword, 
  }) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return Left(Failure('User not logged in'));

      await firestore.collection('users').doc(user.uid).update({
        'name': name,
        'phone': phone,
        'email': email,
      });

      if (email != user.email || (password != null && password.isNotEmpty)) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);

        if (email != user.email) {
          await user.verifyBeforeUpdateEmail(email);
        }

        if (password != null && password.isNotEmpty) {
          await user.updatePassword(password);
        }
      }

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure('Firebase Auth Error: ${e.code}'));
    } catch (e) {
      return Left(Failure('Unexpected Error: ${e.toString()}'));
    }
  }
}
