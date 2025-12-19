import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/function/validators.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/core/utils/widgets/custom_elevated_button.dart';
import 'package:dentiq/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

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
            left: 20, right: 20, top: 50, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
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
                        fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
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
               
            Text(
            'Full Name *',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
            ),
                  ),
                  const SizedBox(height: 6),

                  CustomFormField(
                    validator: (value){
                   return   Validators.nameValidator(value);
                    },
                    hint: 'Full Name',
                    controller: nameController,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
            Text(
            'Email Address *',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
            ),
                  ),
                  const SizedBox(height: 6),

                  // Email
                  CustomFormField(
                    validator: (value){
                   return   Validators.emailValidator(value);
                    },
                    hint: 'Email Address',
                    controller: emailController,
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),
            Text(
            'Phone Number *',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
            ),
                  ),
                  const SizedBox(height: 6),

                  // Phone Number
                  CustomFormField(
                    validator: (value){
                   return   Validators.phoneValidator(value);
                    },
                    hint: 'Phone Number',
                    controller: phoneController,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
            
             Text(
            'Gender *',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
            ),
                  ),  
                  const SizedBox(height: 6),
   // Gender Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.primary!.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   
                  Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Male'),
                  value: 'Male',
                  groupValue: gender,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Female'),
                  value: 'Female',
                  groupValue: gender,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),
            ],
                  ),
                ],
              ),
            ),



                  const SizedBox(height: 16),
                Text(
            'Password *',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
            ),
               
                ),
                const SizedBox(height: 6),
     const Text(
  'Password must contain:',
  style: TextStyle(fontSize: 12, color: AppColors.blackColor),
),
const SizedBox(height: 8),

Wrap(
  spacing: 16, 
  runSpacing: 8, 
  children: [
    _passwordRuleRow('At least 8 characters'),
    _passwordRuleRow('One uppercase letter'),
    _passwordRuleRow('One lowercase letter'),
    _passwordRuleRow('One number'),
    _passwordRuleRow('One special character'),
  ],
),
                const SizedBox(height: 8),
  // Password
                  CustomFormField(
                    hint: 'Password',
                    controller: passwordController,
                    icon: Icons.lock_outline,
                    obscure: obscurePassword,
                           validator: (value){
                   return   Validators.passwordValidator(value);
                    },
                    suffixIcon: obscurePassword ? Icons.visibility_off : Icons.visibility,
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                   Text(
            'Confirm Password *',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
            ),
               
                ),
                  // Confirm Password
                  const SizedBox(height: 6),

                  CustomFormField(
                    validator: (value){
                 return     Validators.confirmPasswordValidator(value, confirmPasswordController.text);
                    },
                    hint: 'Confirm Password',
                    controller: confirmPasswordController,
                    icon: Icons.lock_outline,
                    obscure: obscureConfirmPassword,
                    suffixIcon: obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
            
            
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.primary,
                        value: agreeTerms,
                        onChanged: (val) {
                          setState(() {
                            agreeTerms = val!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I agree to the Terms and Conditions',
                          style: AppStyle.text16.copyWith(color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
            
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: CustomElevatedButton(
                      radius: 12,
                      text: 'Sign Up',
                      textStyle: AppStyle.text18.copyWith(color: Colors.white),
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        if (formKey.currentState!.validate() && agreeTerms) {
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: AppStyle.text16.copyWith(
                              color: AppColors.blackColor, ),
                        ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); 
                        },
                        child: Text(
                          'Log In',
                          style: AppStyle.text16.copyWith(
                              color: AppColors.darkBlue, fontWeight: FontWeight.bold),
                        ),
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
  Widget _passwordRuleRow(String text) {
  return SizedBox(
    width: 160, 
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          '• ',
          style: TextStyle(fontSize: 12, color:AppColors.blackColor),
        ),
        Expanded(
          child: Text(
            text,
            style:  TextStyle(fontSize: 12, color: AppColors.blackColor.withOpacity(.7)),
          ),
        ),
      ],
    ),
  );
}

}
