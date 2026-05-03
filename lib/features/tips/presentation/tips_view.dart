import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/tips/presentation/view_model/cubit/articles_cubit.dart';
import 'package:dentiq/features/tips/presentation/view_model/videos_cubit/videos_cubit_cubit.dart';
import 'package:dentiq/features/tips/presentation/widgets/tips_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<VideosCubit>()..getVideos(),
          ),
          BlocProvider(
            create: (context) => getIt.get<ArticlesCubit>()..getArticles(),
          ),
        ],
        child: TipsViewBody(),
      ),
    );
  }
}
