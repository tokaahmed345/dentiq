import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/core/utils/widgets/custom_elevated_button.dart';
import 'package:dentiq/core/utils/widgets/custom_text_form_field.dart';
import 'package:dentiq/core/utils/widgets/snackbar.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({
    super.key,
  });

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 50,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        // padding: const EdgeInsets.symmetric(vertical: 70,horizontal: 10),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppAssets.tooth),
            ),
            const SizedBox(height: 40),
            Text(
              'Enter your email to receive a password reset link.',
              style: AppStyle.text16.copyWith(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: CustomFormField(
                controller: emailController,
                hint: 'Email Address',
                icon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
  if (state is ForgotPasswordFailure) {
                      showSnackBarFuction(context, state.errorMessage, isError: true);
                    }
                    if (state is ForgotPasswordSuccess) {
                      showSnackBarFuction(
                              context,
                                      "A password reset link has been sent to your email if it is registered with us.", isError: false)
                          .then((_) {
                            GoRouter.of(context).pop();
                      });
                    }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: CustomElevatedButton(
                    text: 'Send Reset Link',
                    backgroundColor: AppColors.primary,
                    textStyle: AppStyle.text18.copyWith(color: Colors.white),
                    radius: 12,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ForgotPasswordCubit>().sendLink(emailController.text.trim());
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
