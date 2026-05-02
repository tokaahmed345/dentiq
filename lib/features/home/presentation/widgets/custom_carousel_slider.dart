import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return    CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,  
              enableInfiniteScroll: true,
            ),
            items: [
              buildCarouselCard(AppAssets.keepTeeth, "Keep Your Teeth Healthy!"),
              buildCarouselCard(AppAssets.floosTeeth, "Don't Forget To Floss!"),
              buildCarouselCard(AppAssets.scanTeeth, "Scan Your Teeth Regularly"),
            ],
          );
  
  }
  Widget buildCarouselCard(String image, String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(
            image,
            fit: BoxFit.fill,

            width: double.infinity,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6), 
                  Colors.transparent,
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(1, 1),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}