import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/progress_tracker/presentation/widgets/progress_view_body.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: const CustomAppBar(title: "progress"),
        body: ProgressViewBody());
  }
}
