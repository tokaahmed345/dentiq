import 'package:bloc/bloc.dart';
import 'package:dentiq/features/tips/data/models/articles_model.dart';
import 'package:dentiq/features/tips/data/repo/articles_repo/article_repo.dart';
import 'package:equatable/equatable.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit(this.articleRepo) : super(ArticlesInitial());
  final ArticleRepo articleRepo;
 
  Future<void> getArticles() async {
    emit(ArticlesLoading());

    final result = await articleRepo.getAllArticles();

    result.fold(
      (failure) => emit(ArticlesFailure(errorMessage:  failure.message)),
      (success) => emit(ArticlesSuccess(articles: success)),
    );
  } 

}
