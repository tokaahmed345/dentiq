import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/features/onboarding/presentation/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';




class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        body:OnBoardingViewBody()
      ),
    );
  }






  
}

