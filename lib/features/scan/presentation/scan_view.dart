import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/scan/presentation/view_model/detection_cubit/detection_cubit.dart';
import 'package:dentiq/features/scan/presentation/widgets/scan_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DetectionCubit>(),
      child: const Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(child: ScanViewBody()),
      )),
    );
  }


}
