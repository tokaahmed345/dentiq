
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentiq/features/auth/data/repos/sign_up_repo/sign_up_repo.dart';
import 'package:dentiq/features/auth/data/repos/sign_up_repo/sign_up_repo_impl.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setUp(){
  getIt.registerLazySingleton<FirebaseAuth>(()=>FirebaseAuth.instance);
    getIt.registerLazySingleton<FirebaseFirestore>(()=>FirebaseFirestore.instance);

  getIt.registerLazySingleton<SignUpRepo>(()=>SignUpRepoImpl(firebaseAuth:  getIt.get<FirebaseAuth>(), firestore:getIt.get<FirebaseFirestore>() ));
  getIt.registerFactory<SignUpCubit>(()=>SignUpCubit(getIt.get<SignUpRepo>()));
 
}
