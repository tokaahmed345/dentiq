import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScanViewBody extends StatelessWidget {
  const ScanViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
       const SizedBox(height: 24),
              _buildScanCard(),
              const SizedBox(height: 24),
              _buildTips(),
              _buildButtons(),
              const SizedBox(height: 24),
    ],);
  }
  
  Widget _buildScanCard() {
    return Container(
      height: 360,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            Color(0xff0F172A),
            Color(0xff020617),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Lottie Frame Animation
          Lottie.asset(
            AppAssets.scan,
          ),

          /// Text Overlay
          Positioned(
            bottom: 40,
            child: Column(
              children: const [
                Text(
                  'Position your teeth in the frame',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Make sure the area is well lit',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTips() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffEEF2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Tips for best results:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          _TipItem(text: 'Ensure good lighting conditions'),
          _TipItem(text: 'Keep your teeth centered in the frame'),
          _TipItem(text: 'Hold your phone steady while scanning'),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient:  LinearGradient(
                colors: [AppColors.primary!, AppColors.darkBlue],
              ),
            ),
            child:  Center(
              child: Text(
                'Capture & Scan Now',
                style: AppStyle.text16.copyWith( color:AppColors.whiteColor,
                  fontWeight: FontWeight.w600,)
                
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload),
            label: const Text('Upload from Gallery'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;
  const _TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}