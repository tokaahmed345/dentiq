import 'package:dentiq/core/utils/router/routes_name.dart';
import 'package:dentiq/features/auth/presentation/forgot_password_view.dart';
import 'package:dentiq/features/auth/presentation/log_in_view.dart';
import 'package:dentiq/features/auth/presentation/sign_up_view.dart';
import 'package:dentiq/features/onboarding/presentation/onboarding_view.dart';
import 'package:dentiq/features/splash/presentation/splash_view.dart';
import 'package:go_router/go_router.dart';
class AppRouter {
   static final  router=GoRouter(
    routes: [
      GoRoute(path:RoutesName.splash,
      name: RoutesName.splash,
      builder: (context,state)=>const SplashView()
      
       ),
         GoRoute(path:RoutesName.onBoardingOne,
      name: RoutesName.onBoardingOne,
      builder: (context,state)=> const OnBoardingView()
      
       ),
       GoRoute(path:RoutesName.logIn ,
             name: RoutesName.logIn,

             builder: (context,state)=> const LogInView()

       ),
        GoRoute(path:RoutesName.signup ,
             name: RoutesName.signup,

             builder: (context,state)=> const SignUpView()

       )
,
      GoRoute(path:RoutesName.forgotPassword ,
             name: RoutesName.forgotPassword,

             builder: (context,state)=> const ForgetPasswordView()

       )
    ]
   );
}