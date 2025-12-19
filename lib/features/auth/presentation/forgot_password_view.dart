import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/core/utils/widgets/custom_elevated_button.dart';
import 'package:dentiq/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
            SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomElevatedButton(
                text: 'Send Reset Link',
                backgroundColor: AppColors.primary,
                textStyle: AppStyle.text18.copyWith(color: Colors.white),
                radius: 12,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
