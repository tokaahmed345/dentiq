import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/router/routes_name.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/core/utils/widgets/custom_elevated_button.dart';
import 'package:dentiq/features/onboarding/data/model/onboarding_data.dart';
import 'package:dentiq/features/onboarding/presentation/widgets/dot_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
    final PageController _controller = PageController();
 int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 70.0,horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                              borderRadius: BorderRadius.circular(20), 
                  
                          child: Image.asset(
                            onboardingData[index].image,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        onboardingData[index].title,
                        style:AppStyle.text28.copyWith(color: AppColors.primary),                        
                        
                         
                      ),
                      const SizedBox(height: 20),
                      Text(
                        onboardingData[index].description,
                        textAlign: TextAlign.center,
                        style: AppStyle.text18.copyWith(color: AppColors.blueGrey,fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => DotBuilder(index: index, currentPage: currentPage,),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go(RoutesName.logIn);
                  },
                  child: Text(
                    "Skip",
                                          style: AppStyle.text18.copyWith(color: AppColors.primary),
            
                  ),
                ),

                CustomElevatedButton(
                  backgroundColor:AppColors.primary ,
                  padding:  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),

                 text: currentPage == onboardingData.length - 1 ? "Start" : "Next", onPressed: () { 
                     if (currentPage == onboardingData.length - 1) {
                                                                GoRouter.of(context).go(RoutesName.logIn);

                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );

                    }
                   },textStyle: AppStyle.text18,)
  
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
  }
}