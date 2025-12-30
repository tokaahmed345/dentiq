import 'package:dentiq/core/utils/router/app_router.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    setUp();
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);


  runApp(const DentiqApp());
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
