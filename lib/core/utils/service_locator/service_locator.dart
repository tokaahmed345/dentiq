
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentiq/core/utils/sharedprefrence.dart';
import 'package:dentiq/features/auth/data/repos/forgot_password_repo/forgot_password.dart';
import 'package:dentiq/features/auth/data/repos/forgot_password_repo/forgot_password_repo_impl.dart';
import 'package:dentiq/features/auth/data/repos/log_in_repo/log_in_repo.dart';
import 'package:dentiq/features/auth/data/repos/log_in_repo/log_in_repo_impl.dart';
import 'package:dentiq/features/auth/data/repos/sign_up_repo/sign_up_repo.dart';
import 'package:dentiq/features/auth/data/repos/sign_up_repo/sign_up_repo_impl.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/log_in_cubit/log_in_cubit.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:dentiq/features/progress_tracker/data/repos/daily_progress_repo.dart';
import 'package:dentiq/features/progress_tracker/data/repos/daily_progress_repo_impl.dart';
import 'package:dentiq/features/progress_tracker/presentation/view_model/progress_tracker_cubit/progress_tracker_cubit.dart';
import 'package:dentiq/features/tips/data/repo/articles_repo/article_repo.dart';
import 'package:dentiq/features/tips/data/repo/articles_repo/article_repo_impl.dart';
import 'package:dentiq/features/tips/data/repo/video_repo/video_repo.dart';
import 'package:dentiq/features/tips/data/repo/video_repo/video_repo_impl.dart';
import 'package:dentiq/features/tips/presentation/view_model/cubit/articles_cubit.dart';
import 'package:dentiq/features/tips/presentation/view_model/videos_cubit/videos_cubit_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setUp(){
  getIt.registerLazySingleton<FirebaseAuth>(()=>FirebaseAuth.instance);
    getIt.registerLazySingleton<FirebaseFirestore>(()=>FirebaseFirestore.instance);
getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());

  getIt.registerLazySingleton<SignUpRepo>(()=>SignUpRepoImpl(firebaseAuth:  getIt.get<FirebaseAuth>(), firestore:getIt.get<FirebaseFirestore>(), sharedPrefs: getIt.get<SharedPrefs>() ));
  getIt.registerFactory<SignUpCubit>(()=>SignUpCubit(getIt.get<SignUpRepo>()));
   getIt.registerLazySingleton<LogInRepo>(()=>LogInRepoImpl(firebaseAuth:  getIt.get<FirebaseAuth>(), sharedPrefs:getIt.get<SharedPrefs>()  ,  ));
  getIt.registerFactory<LogInCubit>(()=>LogInCubit( getIt.get<LogInRepo>()));
    getIt.registerLazySingleton<ForgotPasswordRepo>(()=>ForgotPasswordRepoImpl(  getIt.get<FirebaseAuth>(),  ));
  getIt.registerFactory<ForgotPasswordCubit>(()=>ForgotPasswordCubit( getIt.get<ForgotPasswordRepo>()));
 
     getIt.registerLazySingleton<VideoRepo>(()=>VideoRepoImpl( firebaseFirestore:  getIt.get<FirebaseFirestore>(),  ));
  getIt.registerFactory<VideosCubit>(()=>VideosCubit( getIt.get<VideoRepo>()));
 

      getIt.registerLazySingleton<ArticleRepo>(()=>ArticleRepoImpl( firebaseFirestore:  getIt.get<FirebaseFirestore>(),  ));
  getIt.registerFactory<ArticlesCubit>(()=>ArticlesCubit( getIt.get<ArticleRepo>()));
 
 
      getIt.registerLazySingleton<ProgressRepo>(()=>DailyProgressRepoImpl( firestore:  getIt.get<FirebaseFirestore>(), sharedPreferences: getIt.get<SharedPrefs>() ));
  getIt.registerFactory<ProgressTrackerCubit>(()=>ProgressTrackerCubit( getIt.get<ProgressRepo>()));
 
}
