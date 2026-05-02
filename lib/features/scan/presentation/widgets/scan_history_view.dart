import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/scan/presentation/widgets/scan_history_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.blue[50],
 
      appBar: CustomAppBar(
        arrowBack: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 27,
          ),
        ),
        title: "Scan History",
      ),
      body: const ScanHistoryViewBody(),
    );
  }
}
