import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:dentiq/features/auth/presentation/widgets/forgot_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: Text(
          'Forget Password',
          style: AppStyle.text20.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primary,
            )),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<ForgotPasswordCubit>(),
        child: const ForgotPasswordViewBody(),
      ),
    );
  }
}
