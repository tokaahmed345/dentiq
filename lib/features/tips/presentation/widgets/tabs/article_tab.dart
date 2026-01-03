

import 'package:dentiq/features/tips/presentation/view_model/cubit/articles_cubit.dart';
import 'package:dentiq/features/tips/presentation/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';

class ArticlesTab extends StatelessWidget {
  const ArticlesTab({super.key});

  // Shimmer Card
  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
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
          // Image placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Text placeholders
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  Container(
                    height: 14,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  Container(
                    height: 14,
                    width: 150,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesState>(
      builder: (context, state) {
        if (state is ArticlesSuccess) {
          final articles = state.articles;
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(article: article);
            },
          );
        } else if (state is ArticlesFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          // Shimmer loading
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8),
            itemCount:10,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: AppColors.primary!.withOpacity(.1),
                highlightColor: AppColors.primary!.withOpacity(.2),
                child: _buildShimmerCard(),
              );
            },
          );
        }
      },
    );
  }
}
