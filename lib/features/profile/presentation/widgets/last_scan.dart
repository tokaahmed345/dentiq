import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/scan/presentation/view_model/last_scan_cubit/last_scan_cubit.dart';
import 'package:dentiq/features/scan/presentation/view_model/scan_count_cubit/scan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LastScanCard extends StatelessWidget {
  const LastScanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<LastScanCubit, LastScanState>(
        builder: (context, state) {
          String label = "No scans yet";
          String confidence = "";
          String date = "";

          if (state is ScanLastSuccess && state.data.isNotEmpty) {
            label = state.data['label'] ?? "";
            confidence = ((state.data['confidence'] ?? 0.0) * 100).toStringAsFixed(0) + "%";
            final timestamp = state.data['date'] as Timestamp?;
            if (timestamp != null) {
              date = "${timestamp.toDate().day}-${timestamp.toDate().month}-${timestamp.toDate().year}";
            }
          }

          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              // Colors.white,
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
                    children: [
                      const Text("Last Scan", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        "$label • $confidence",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}
