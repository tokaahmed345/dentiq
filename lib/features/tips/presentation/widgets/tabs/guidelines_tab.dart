import 'package:dentiq/features/tips/presentation/widgets/guideline_tile.dart';
import 'package:flutter/material.dart';

class GuidelinesTab extends StatelessWidget {
  const GuidelinesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: const [
        GuidelineTile(
          number: 1,
          title: 'Daily Brushing Tips',
          points: [
            'Brush twice a day',
            'Use soft toothbrush',
            'Don’t forget the tongue',
          ],
        ),
        GuidelineTile(
          number: 2,
          title: 'Healthy Habits',
          points: [
            'Avoid sugary drinks',
            'Drink water regularly',
            'Visit dentist every 6 months',
          ],
        ),
      ],
    );
  }
}