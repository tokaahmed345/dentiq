
import 'package:dentiq/features/tips/presentation/widgets/article_card.dart';
import 'package:flutter/material.dart';

class ArticlesTab extends StatelessWidget {
  const ArticlesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const ArticleCard();
      },
    );
  }
}