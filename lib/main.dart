import 'package:dentiq/core/utils/router/app_router.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/core/utils/themes/app_theme.dart';
import 'package:dentiq/core/utils/themes/theme_cubit/theme_cubit.dart';
import 'package:dentiq/features/home/presentation/view_model/cubit/progress_home_tracker_cubit.dart';
import 'package:dentiq/features/progress_tracker/presentation/view_model/progress_tracker_cubit/progress_tracker_cubit.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/cubit/reminder_history_cubit.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/dental_reminder_cubit.dart';
import 'package:dentiq/features/scan/data/model/local_model/local_model.dart';
import 'package:dentiq/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  await Supabase.initialize(
    url: 'https://sdyzanmqockopnauzxya.supabase.co',
    anonKey: 'sb_publishable_XHH4GYKnRIouLF3GrPLQLg_DnoMKJ6W',
  );
  setUp();

  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(LocalScanModelAdapter());

  await Hive.openBox<LocalScanModel>('scans');

  runApp(MultiBlocProvider(
    providers: [
    

      BlocProvider(
        create: (_) => getIt<ProgressTrackerCubit>()..trackProgress(),
      ),
      BlocProvider(
        create: (_) => getIt<ProgressHomeTrackerCubit>(),
      ),
      BlocProvider(
        create: (_) => getIt<DentalReminderCubit>(),
      ),

      BlocProvider(
        create: (_) => getIt<ReminderHistoryCubit>(),
      ),
      
      BlocProvider(
        create: (_) => ThemeCubit()..loadTheme(),
      ),
    ],
    child: const DentiqApp(),
  ));
}

class DentiqApp extends StatelessWidget {
  const DentiqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, thememode) {
        return MaterialApp.router(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: thememode,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
