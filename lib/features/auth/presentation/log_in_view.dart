
import 'package:dentiq/features/auth/presentation/widgets/log_in_view_body.dart';
import 'package:flutter/material.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Padding(

          padding:  EdgeInsets.only(           bottom: MediaQuery.of(context).viewInsets.bottom + 20,
),
          child: SafeArea(
            child:LogInViewBody() ,
          ),
        ),
      ),
    );
  }

 
}
