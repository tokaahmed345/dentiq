import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/core/utils/sharedprefrence.dart';
import 'package:dentiq/features/auth/data/model/sign_up_model.dart';
import 'package:dentiq/features/auth/data/repos/sign_up_repo/sign_up_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpRepoImpl extends SignUpRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final SharedPrefs sharedPrefs;
  SignUpRepoImpl({
    required this.firebaseAuth,
required this.firestore, required this.sharedPrefs,
  }) ;

  @override
  Future<Either<Failure, SignUpModel>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String gender,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = SignUpModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        gender: gender,
      );

      await firestore.collection('users').doc(user.id).set(user.toMap());

      await  sharedPrefs.saveUserId(user.id);
await sharedPrefs.saveUserName(name); 
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
