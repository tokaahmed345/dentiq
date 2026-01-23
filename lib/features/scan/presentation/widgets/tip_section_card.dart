import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class TipsSection extends StatelessWidget {
  const TipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.tipsBackground,
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

}

class _TipItem extends StatelessWidget {
  final String text;
  const _TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: const [
          Icon(Icons.check_circle, color: AppColors.greenColor, size: 18),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
