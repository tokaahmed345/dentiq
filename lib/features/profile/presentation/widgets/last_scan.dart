import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LastScanCard extends StatelessWidget {
  const LastScanCard();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.health_and_safety, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Last Scan", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text("Healthy • 92%", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Text("Dec 15", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
