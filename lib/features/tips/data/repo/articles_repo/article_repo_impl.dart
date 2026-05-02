import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/tips/data/models/articles_model.dart';
import 'package:dentiq/features/tips/data/repo/articles_repo/article_repo.dart';

class ArticleRepoImpl extends ArticleRepo{
  final FirebaseFirestore firebaseFirestore;

 ArticleRepoImpl ({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, List<Article>>>getAllArticles() async {
    try {
final snapshot= await firebaseFirestore
        .collection('articles').get();
         final articles = snapshot.docs
        .map((doc) => Article.fromMap(doc.data())).toList()
        .toList();
     return right(articles);
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
