import 'package:dentiq/core/utils/router/routes_name.dart';
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
      builder: (context,state)=> OnBoardingView()
      
       )
    ]
   );
}