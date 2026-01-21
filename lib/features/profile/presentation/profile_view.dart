import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/profile/presentation/view_model/cubit/profile_image_cubit.dart';
import 'package:dentiq/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: BlocProvider(
        create: (context) => getIt.get<ProfileHeaderCubit>(),
        child: const ProfileViewBody(),
      ),
    );
  }
}
