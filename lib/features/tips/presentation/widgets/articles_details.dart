
import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleDetailsView extends StatelessWidget {
  const ArticleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 18,
                  backgroundColor: Colors.white54,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon:  Icon(
                      Icons.arrow_back_ios_new,
                      size: 27,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
              ),
            ),
            automaticallyImplyLeading: false,
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                    AppAssets.onboardingTwo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                const [
                  Text(
                    'How to Brush Your Teeth Properly',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Proper brushing technique is essential for maintaining good oral health...\n\n'
                    '• Use a soft-bristled toothbrush\n'
                    '• Brush at a 45-degree angle\n'
                    '• Brush for at least two minutes\n'
                    '• Don’t forget your tongue\n',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
