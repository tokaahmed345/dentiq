import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/tips/data/models/articles_model.dart';

abstract class ArticleRepo {
  Future<Either<Failure,List<Article>>>getAllArticles();
}