import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



// ================= TIPS =================
class TipsSectionProfile extends StatelessWidget {
  const TipsSectionProfile({super.key, });
 final List<String> tips = const [
    "Brush twice daily",
    "Floss regularly",
    "Use mouthwash",
    "Regular dental checkups",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tips for you",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tips
                .map((e) => Chip(
                      label: Text(e, style: const TextStyle(color: Colors.white)),
                      backgroundColor: AppColors.primary,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}