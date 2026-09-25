import 'package:dentiq/core/utils/assets/app_assets.dart';

class OnBoardingData {
final String image;
final String title;
final String description;
  OnBoardingData({required this.image, required this.title, required this.description});

}

final List<OnBoardingData> onboardingData=[
  OnBoardingData(image: AppAssets.onboardingOne,
      title: "AI Detection",
      description: "Detect dental issues easily and quickly using artificial intelligence.", ),
      OnBoardingData(    image:AppAssets.onboardingTwo,
      title: "Tips",
      description: "Get daily tips for proper dental care."),
      OnBoardingData(
            image: AppAssets.onboardingThree,
      title: "Educate",
      description: "Learn everything you need to know about oral health easily."
      ),

];