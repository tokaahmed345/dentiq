import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/tips/presentation/view_model/cubit/videos_cubit_cubit.dart';
import 'package:dentiq/features/tips/presentation/widgets/tips_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: BlocProvider(
        create: (context) => getIt.get<VideosCubit>()..getVideos(),
        child: TipsViewBody(),
      ),
    );
  }
}
