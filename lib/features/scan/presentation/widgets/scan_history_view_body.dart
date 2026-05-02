
import 'dart:io';

import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/scan/presentation/view_model/cubit/scan_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ScanHistoryViewBody extends StatelessWidget {
  const ScanHistoryViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanHistoryCubit, ScanHistoryState>(
      builder: (context, state) {
        if (state is ScanHistoryLoading) {
return ListView.builder(
  scrollDirection: Axis.vertical,
  
  itemCount: 10, 
  itemBuilder: (context, index) {
    return Shimmer.fromColors(
      baseColor: AppColors.primary!.withOpacity(.1),  
      highlightColor: AppColors.primary!.withOpacity(.2), 
      child: _buildShimmerCard(),
    );
  },
);
        }
    
        if (state is ScanHistorySuccess) {
          if (state.scans.isEmpty) {
            return  Center(
              child: Text(
                "No scans yet",
                style: TextStyle(fontSize: 18, color: AppColors.grey),
              ),
            );
          }
    
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.scans.length,
            itemBuilder: (context, index) {
              final scan = state.scans[index];
              final dateTime = DateFormat('dd/MM/yyyy – hh:mm a').format(scan.date);
    
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: AppColors.whiteColor,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    scan.label,
                    style:  const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.blackColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        "Confidence: ${(scan.confidence * 100).toStringAsFixed(2)}%",
                        style:  TextStyle(color: AppColors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateTime, // shows date + time
                        style:  TextStyle(color: AppColors.grey),
                      ),
                    ],
                  ),
                  leading: ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: scan.imageUrl.startsWith('http')
      ? Image.network(
          scan.imageUrl,
          width: 100,
          height: 150,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
        )
      : Image.file(
          File(scan.imageUrl),
          width: 100,
          height: 150,
          fit: BoxFit.cover,
        ),
),
                ),
              );
            },
          );
        }
    
        if (state is ScanHistoryFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: AppColors.redColor, fontSize: 16),
            ),
          );
        }
    
        return const SizedBox();
      },
    );
  }
 Widget _buildShimmerCard() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
    child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), 
      ),
      color: AppColors.whiteColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12), 
          child: Container(
            width: 100,
            height: 150,
            color: Colors.grey.shade300,
          ),
        ),
    
        title: Container(
          height: 18,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
    
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              height: 14,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 14,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}