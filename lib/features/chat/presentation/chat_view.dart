import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/chat/presentation/view_model/cubit/chat_cubit.dart';
import 'package:dentiq/features/chat/presentation/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ChatCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
            arrowBack: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.whiteColor,
                  size: 27,
                )),
            title: "Chat Assistant"),
        body: const ChatViewBody(),
      ),
    );
  }
}
