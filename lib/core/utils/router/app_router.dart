import 'package:dentiq/core/utils/router/routes_name.dart';
import 'package:dentiq/features/auth/presentation/forgot_password_view.dart';
import 'package:dentiq/features/auth/presentation/log_in_view.dart';
import 'package:dentiq/features/auth/presentation/sign_up_view.dart';
import 'package:dentiq/features/home/presentation/home_view.dart';
import 'package:dentiq/features/onboarding/presentation/onboarding_view.dart';
import 'package:dentiq/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:dentiq/features/splash/presentation/splash_view.dart';
import 'package:dentiq/features/tips/presentation/tips_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null && state.name != RoutesName.home) {
        return RoutesName.home;
      }

      if (user == null && state.name == RoutesName.home) {
        return RoutesName.logIn;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutesName.splash,
        name: RoutesName.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RoutesName.onBoardingOne,
        name: RoutesName.onBoardingOne,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: RoutesName.logIn,
        name: RoutesName.logIn,
        builder: (context, state) => const LogInView(),
      ),
      GoRoute(
        path: RoutesName.signup,
        name: RoutesName.signup,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: RoutesName.forgotPassword,
        name: RoutesName.forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: RoutesName.home,
        name: RoutesName.home,
        builder: (context, state) => const HomeView(),
      ),
       GoRoute(
        path: RoutesName.scan,
        name: RoutesName.scan,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: RoutesName.tips,
        name: RoutesName.tips,
        builder: (context, state) => const TipsView(),
      ),
           GoRoute(
        path: RoutesName.profile,
        name: RoutesName.profile,
        builder: (context, state) => const ProfileViewBody(),
      ),
    ],
  );
}
