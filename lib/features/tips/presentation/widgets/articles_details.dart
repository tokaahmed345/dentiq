
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/tips/data/models/articles_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleDetailsView extends StatelessWidget {
  const ArticleDetailsView({super.key, required this.article});
final Article article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const CustomArrowBack(),
            automaticallyImplyLeading: false,
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  article.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                 [
                  Text(
                   article.title,
                    style: AppStyle.text20.copyWith(color: AppColors.primary,    fontWeight: FontWeight.bold,)
                    
                 
                  ),
                  const SizedBox(height: 12),
                  
                  Text(
                   article.content,
                                        style: AppStyle.text16.copyWith(color:  Theme.of(context).colorScheme.onSurface,)

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

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
