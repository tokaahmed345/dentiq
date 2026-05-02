import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/log_in_cubit/log_in_cubit.dart';
import 'package:dentiq/features/auth/presentation/widgets/log_in_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[50],
      body: BlocProvider(
        create: (context) => getIt.get<LogInCubit>(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SafeArea(
              child: LogInViewBody(),
            ),
          ),
        ),
      ),
    );
  }
}
