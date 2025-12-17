import 'package:dentiq/core/utils/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
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
