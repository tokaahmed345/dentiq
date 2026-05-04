import 'package:dentiq/features/tips/presentation/widgets/tabs/article_tab.dart';
import 'package:dentiq/features/tips/presentation/widgets/tabs/guidelines_tab.dart';
import 'package:dentiq/features/tips/presentation/widgets/tabs/videos_tab.dart';
import 'package:flutter/material.dart';

class TipsViewBody extends StatelessWidget {
  const TipsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        VideosTab(),
        // GuidelinesTab(),

        ArticlesTab(),
        GuidelinesTab(),
      ],
    );
  }
}
