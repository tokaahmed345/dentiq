import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/tips/data/models/articles_model.dart';
import 'package:dentiq/features/tips/presentation/widgets/articles_details.dart';
import 'package:flutter/material.dart';


class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailsView(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface
          ,
          // AppColors.whiteColor.withOpacity(.5), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
              child:Image.network(
                article.imageUrl,
                  width: 120,
                height: 120,
                fit: BoxFit.cover,
errorBuilder: (context, url, error) => Icon(Icons.error),
              )
            
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                                         style: AppStyle.text18.copyWith(color:  Theme.of(context).colorScheme.primary
                                         
                                          // AppColors.primary,
                                          ,
                                              fontWeight: FontWeight.bold,)

                   
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.subtitle,
                    style: AppStyle.text16.copyWith(color:
                    Theme.of(context).colorScheme.onPrimary
                    //  AppColors.blueGrey!.withOpacity(.5), 
                        )
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
