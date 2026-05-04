import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:dentiq/features/auth/presentation/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => getIt.get<SignUpCubit>(),
        child: const SignUpViewBody(),
      ),
    );
  }
}
