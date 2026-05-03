import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
class TipsSectionCard extends StatelessWidget {
  final List<String> tips;
  const TipsSectionCard({super.key, required this.tips});

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
        children: [
           Text(
            'Tips for best results:',
            style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).cardColor),
          ),
          const SizedBox(height: 12),
          ...tips.map((tip) => TipItem(text: tip)).toList(),
        ],
      ),
    );
  }
}


class TipItem extends StatelessWidget {
  final String text;
  const TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children:  [
          Icon(Icons.check_circle, color: AppColors.greenColor, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
                text,
                style:  TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).cardColor
                ),
              ),
          ),
        ],
      ),
    );
  }
}
