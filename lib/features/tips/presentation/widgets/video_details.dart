
import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';

class VideoDetailsView extends StatelessWidget {
  const VideoDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                    AppAssets.onboardingTwo,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Positioned.fill(
                child: Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.play_arrow, size: 36),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'How to Brush Your Teeth Properly',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}