import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/progress_tracker/presentation/progress_view.dart';
import 'package:dentiq/features/reminder/presentation/reminder_view.dart';
import 'package:dentiq/features/scan/presentation/scan_view.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                buildFeatureCard(
                  icon: Icons.alarm,
                  
                  title: "Reminders",
                  color: AppColors.primary!,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ReminderView()));
                  },
                ),
                buildFeatureCard(
                  icon: Icons.show_chart,
                  title: "Progress",
                  color: AppColors.primary!,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProgressView()));
                  },
                ),
                  buildFeatureCard(
                  icon: Icons.camera_alt_outlined,
                  
                  title: "Scan",
                  color: AppColors.primary!,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ScanView()));
                  },
                ),
              ],
            ),
          );
  }
  

  Widget buildFeatureCard({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.whiteColor)),
          ],
        ),
      ),
    );
  }
}

