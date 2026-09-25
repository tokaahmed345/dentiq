import 'package:dentiq/features/tips/presentation/widgets/guideline_tile.dart';
import 'package:flutter/material.dart';

class GuidelinesTab extends StatelessWidget {
  const GuidelinesTab({super.key});

 final List<Map<String, dynamic>> guidelines = const [
  {
    'number': 1,
    'title': 'Daily Brushing Tips',
    'points': ['Brush twice a day', 'Use soft toothbrush', 'Don’t forget the tongue'],
  },
  {
    'number': 2,
    'title': 'Healthy Habits',
    'points': ['Avoid sugary drinks', 'Drink water regularly', 'Visit dentist every 6 months'],
  },
  {
    'number': 3,
    'title': 'Flossing & Cleaning',
    'points': ['Floss daily to remove plaque', 'Use mouthwash for extra protection', 'Clean your tongue gently'],
  },
  {
    'number': 4,
    'title': 'Nutrition for Healthy Teeth',
    'points': ['Eat crunchy vegetables and fruits', 'Include dairy products', 'Limit sugary snacks'],
  },
  {
    'number': 5,
    'title': 'General Tips',
    'points': ['Replace toothbrush every 3-4 months', 'Don’t smoke or use tobacco', 'Monitor any tooth pain or sensitivity'],
  },
  {
    'number': 6,
    'title': 'Hydration Matters',
    'points': ['Drink plenty of water daily', 'Water helps wash away food particles', 'Stay hydrated for healthy saliva production'],
  },
  {
    'number': 7,
    'title': 'Regular Dental Checkups',
    'points': ['Schedule dental visits twice a year', 'Follow dentist advice for treatments', 'Keep track of dental records'],
  },
];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: guidelines.length,
      itemBuilder: (context, index) {
        final guideline = guidelines[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GuidelineTile(
            number: guideline['number'],
            title: guideline['title'],
            points: List<String>.from(guideline['points']),
          ),
        );
      },
    );
  }
}
