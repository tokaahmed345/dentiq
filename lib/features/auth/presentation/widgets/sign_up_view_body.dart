import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/function/validators.dart';
import 'package:dentiq/core/utils/router/routes_name.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/core/utils/widgets/custom_elevated_button.dart';
import 'package:dentiq/core/utils/widgets/custom_text_form_field.dart';
import 'package:dentiq/core/utils/widgets/snackbar.dart';
import 'package:dentiq/features/auth/presentation/view_model/auth_cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeTerms = false;
  String? gender;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 50,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
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
          const SizedBox(height: 20),
          Text(
            'Create Account',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          const Text(
            'Sign up to start your dental care journey',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Full Name *',
                    style: TextStyle(fontSize: 14, color: AppColors.primary)),
                const SizedBox(height: 6),
                CustomFormField(
                  validator: (value) => Validators.nameValidator(value),
                  hint: 'Full Name',
                  controller: nameController,
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
    
                Text('Email Address *',
                    style: TextStyle(fontSize: 14, color: AppColors.primary)),
                const SizedBox(height: 6),
                CustomFormField(
                  validator: (value) => Validators.emailValidator(value),
                  hint: 'Email Address',
                  controller: emailController,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
    
                Text('Phone Number *',
                    style: TextStyle(fontSize: 14, color: AppColors.primary)),
                const SizedBox(height: 6),
                CustomFormField(
                  validator: (value) => Validators.phoneValidator(value),
                  hint: 'Phone Number',
                  controller: phoneController,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
    
                Text('Gender *',
                    style: TextStyle(fontSize: 14, color: AppColors.primary)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: gender,
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (value) => setState(() => gender = value),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: gender,
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (value) => setState(() => gender = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
    
                Text('Password *',
                    style: TextStyle(fontSize: 14, color: AppColors.primary)),
                const SizedBox(height: 6),
                CustomFormField(
                  hint: 'Password',
                  controller: passwordController,
                  icon: Icons.lock_outline,
                  obscure: obscurePassword,
                  validator: (value) => Validators.passwordValidator(value),
                  suffixIcon:
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                ),
                const SizedBox(height: 16),
                Text('Confirm Password *',
                    style: TextStyle(fontSize: 14, color: AppColors.primary)),
                const SizedBox(height: 6),
                CustomFormField(
                  hint: 'Confirm Password',
                  controller: confirmPasswordController,
                  icon: Icons.lock_outline,
                  obscure: obscureConfirmPassword,
                  validator: (value) => Validators.confirmPasswordValidator(
                      value, confirmPasswordController.text),
                  suffixIcon: obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onPressed: () =>
                      setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                ),
                const SizedBox(height: 16),
    
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primary,
                      value: agreeTerms,
                      onChanged: (val) => setState(() => agreeTerms = val!),
                    ),
                    Expanded(
                      child: Text('I agree to the Terms and Conditions',
                          style:
                              AppStyle.text16.copyWith(color: Colors.grey.shade700)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
    
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                      print('STATE ===> $state');

                    if (state is SignUpFailure) {
                      showSnackBarFuction(context, state.errorMessage, isError: true);
                    }
                    if (state is SignUpSuccess) {
                      showSnackBarFuction(
                              context, "Account created successfully", isError: false)
                          .then((_) {
                        if (context.mounted) context.go(RoutesName.home);
                      });
                    }
                  },
                  builder: (context, state) {
                return    SizedBox(
      width: double.infinity,
      height: 60,
      child: state is SignUpLoading
    ? Center(
        
        child:  CircularProgressIndicator(
          color: AppColors.primary,
        ),
      )
    : CustomElevatedButton(
        radius: 12,
        text: 'Sign Up',
        textStyle: AppStyle.text18.copyWith(color: AppColors.whiteColor),
        backgroundColor: AppColors.primary,
        onPressed: () {
          if (!agreeTerms) {
            showSnackBarFuction(
                context,
                "You must agree to Terms and Conditions",
                isError: true);
            return;
          }
          if (formKey.currentState!.validate()) {
            context.read<SignUpCubit>().signUp(
                  name: nameController.text,
                  email: emailController.text.trim(),
                  password: passwordController.text,
                  phone: phoneController.text,
                  gender: gender ?? "",
                );
          }
        },
      ),
    );
                  
                  },
                ),
                const SizedBox(height: 20),
    
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: AppStyle.text16.copyWith(color: AppColors.blackColor)),
                    InkWell(
                      onTap: () => GoRouter.of(context).go(RoutesName.logIn),
                      child: Text('Log In',
                          style: AppStyle.text16.copyWith(
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
