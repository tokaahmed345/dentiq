import 'package:dentiq/features/onboarding/data/model/onboarding_data.dart';
import 'package:dentiq/features/onboarding/presentation/widgets/dot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 70.0),
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
                              borderRadius: BorderRadius.circular(20), // لازم هنا كمان
                  
                          child: Image.asset(
                            onboardingData[index].image,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        onboardingData[index].title,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900]),
                      ),
                      SizedBox(height: 20),
                      Text(
                        onboardingData[index].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, color: Colors.blueGrey[800]),
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Skip the onboarding
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      if (currentPage == onboardingData.length - 1) {
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Text(
                      currentPage == onboardingData.length - 1 ? "Start" : "Next",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      );
  }
}