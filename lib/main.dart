import 'package:dentiq/core/utils/router/app_router.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/notifications/data/notifications_service.dart';
import 'package:dentiq/features/notifications/presentation/view_model/cubit/notification_cubit.dart';
import 'package:dentiq/features/progress_tracker/presentation/view_model/progress_tracker_cubit/progress_tracker_cubit.dart';
import 'package:dentiq/features/reminder/data/repos/dental_remider_repo.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/dental_reminder_cubit.dart';
import 'package:dentiq/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  await NotificationService. requestNotificationPermission();
  await NotificationService.testNotification();
  await Supabase.initialize(
    url: 'https://sdyzanmqockopnauzxya.supabase.co',
    anonKey: 'sb_publishable_XHH4GYKnRIouLF3GrPLQLg_DnoMKJ6W',        
  );
  setUp();

  // await InAppWebViewController.setWebContentsDebuggingEnabled(true);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getIt.get<ProgressTrackerCubit>()..trackProgress(),
      ),
        BlocProvider(
        create: (context) => NotificationCubit(),
      ),
      BlocProvider(
        create: (context) => getIt.get<DentalReminderCubit>(),
      ),
    ],
    child: const DentiqApp(),
  ));
}

class DentiqApp extends StatelessWidget {
  const DentiqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
