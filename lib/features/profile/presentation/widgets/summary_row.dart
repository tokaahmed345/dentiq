import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/scan/presentation/view_model/health_risk_cubit/health_risk_cubit.dart';
import 'package:dentiq/features/scan/presentation/view_model/scan_count_cubit/scan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<ScanCubit, ScanState>(
              builder: (context, state) {
                if (state is ScanCountSuccess) {
                  return _SummaryItem(
                    title: "Scans",
                    value: state.count.toString(),
                  );
                } else if (state is ScanCountLoading) {
                  return const _SummaryItem(
                    title: "Scans",
                    value: "...",
                  );
                } else {
                  return const _SummaryItem(
                    title: "Scans",
                    value: "0",
                  );
                }
              },
            ),
          ),

          const SizedBox(width: 14),

          // const Expanded(
          //   child: _SummaryItem(
          //     title: "Score",
          //     value: "85%",
          //   ),
          // ),
          Expanded(
  child: BlocBuilder<HealthRiskCubit, HealthRiskState>(
    builder: (context, state) {
      String value = "...";
      if (state is HealthRiskSuccess) {
        value = "${(state.average * 100).toStringAsFixed(0)}%";
  // value = (state.average == 0) ? "-" : "${(state.average * 100).toStringAsFixed(0)}%";

      }
      return _SummaryItem(
        title: "Health Risk",
        value: value,
      );
    },
  ),
),

        ],
      ),
    );
  }
}


class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary!.withOpacity(0.85),
            AppColors.primary!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 26, // أكبر
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
