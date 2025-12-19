import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/function/validators.dart';
import 'package:dentiq/core/utils/router/routes_name.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/core/utils/widgets/custom_elevated_button.dart';
import 'package:dentiq/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LogInViewBody extends StatefulWidget {
  const LogInViewBody({super.key});

  @override
  State<LogInViewBody> createState() => _LogInViewBodyState();
}

class _LogInViewBodyState extends State<LogInViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey <FormState>formKey=GlobalKey();
   bool obscure=true;
  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppAssets.tooth)),
            const SizedBox(height: 24),
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sign in to continue your dental care journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            CustomFormField(
              validator: (value){
                   return   Validators.emailValidator(value);
                    },
              hint: 'your.email@example.com',
              controller: emailController,
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              validator: (value){
                   return   Validators.passwordValidator(value);
                    },
              hint: '*********',
              obscure: obscure,
              controller: passwordController,
              icon: Icons.lock_outline,
              suffixIcon:obscure? Icons.visibility_off: Icons.visibility,
              onPressed: (){
                setState(() {
                  obscure=! obscure;
                });
              },
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).go(RoutesName.forgotPassword);
                },
                child: Text('Forgot Password?',
                    style: AppStyle.text16.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 62,
                child: CustomElevatedButton(
                    radius: 12,
                    text: "Log In →",
                    textStyle: AppStyle.text18,
                    onPressed: () {
                      if(formKey.currentState!.validate()){

                      }
                    },
                    backgroundColor: AppColors.primary)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text("Don't have an account? ",style: AppStyle.text16.copyWith(color:   AppColors.blackColor),),
                InkWell(
                  onTap: (){
                    GoRouter.of(context).go(RoutesName.signup);
                  },
                  child: Text(
                    'Sign Up',
                    style:AppStyle.text16.copyWith(   color: AppColors.darkBlue,fontWeight: FontWeight.bold)
                    
                             
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
