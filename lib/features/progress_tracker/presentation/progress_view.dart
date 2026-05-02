import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/progress_tracker/presentation/widgets/progress_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar:  CustomAppBar(
          arrowBack: IconButton(onPressed:(){ GoRouter.of(context).pop();}, icon: const Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,size: 27,))
          ,title: "progress"),
        body: ProgressViewBody());
  }
}
