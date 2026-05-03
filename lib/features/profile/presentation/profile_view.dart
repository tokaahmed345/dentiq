import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/auth/presentation/view_model/log_out_cubit/log_out_cubit.dart';
import 'package:dentiq/features/profile/presentation/view_model/cubit/profile_image_cubit.dart';
import 'package:dentiq/features/profile/presentation/view_model/cubit/profile_info_cubit.dart';
import 'package:dentiq/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:dentiq/features/scan/presentation/view_model/health_risk_cubit/health_risk_cubit.dart';
import 'package:dentiq/features/scan/presentation/view_model/last_scan_cubit/last_scan_cubit.dart';
import 'package:dentiq/features/scan/presentation/view_model/scan_count_cubit/scan_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<ProfileHeaderCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<ProfileInfoCubit>()..getProfileData(),
          ),
          
          BlocProvider(
            create: (context) {
              final userId = getIt.get<FirebaseAuth>().currentUser!.uid;
              return getIt.get<ScanCubit>()..fetchScanCount(userId);
            }
            
          ),
          BlocProvider(
            create: (context) {
              final userId = getIt.get<FirebaseAuth>().currentUser!.uid;
              return getIt.get<LastScanCubit>()..fetchLastScan(userId);
            }
          ),
           BlocProvider(
            create: (context) {
              final userId = getIt.get<FirebaseAuth>().currentUser!.uid;
              return getIt.get<HealthRiskCubit>()..fetchHealthRisk(userId);
            }
          )
        ],
        child: const ProfileViewBody(),
      ),
    );
  }
}
