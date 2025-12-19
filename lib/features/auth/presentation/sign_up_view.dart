import 'package:dentiq/features/auth/presentation/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.blue[50],

    resizeToAvoidBottomInset: true,

      body: SignUpViewBody(),
    );
  }
}