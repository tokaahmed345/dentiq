import 'dart:io';
import 'package:dentiq/features/profile/presentation/view_model/cubit/profile_image_cubit.dart';
import 'package:dentiq/features/profile/presentation/view_model/cubit/profile_info_cubit.dart';
import 'package:dentiq/features/scan/presentation/view_model/health_risk_cubit/health_risk_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return Column(
      children: [
        BlocBuilder<ProfileHeaderCubit, ProfileHeaderState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () async {
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  final file = File(pickedFile.path);
                  context.read<ProfileHeaderCubit>().pickAndUploadImage(file);
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 3,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: state.localImage != null
                          ? FileImage(state.localImage!)
                          : (state.imageUrl != null
                              ? NetworkImage(state.imageUrl!) as ImageProvider
                              : null),
                      child: state.localImage == null && state.imageUrl == null
                          ? const Icon(
                              Icons.person,
                              size: 48,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            String name = "";
            if (state is ProfileInfoGetSuccess || state is ProfileInfoUpdateSuccess) {
              name = context.read<ProfileInfoCubit>().nameController.text;
            }
            return Text(
              name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            );
          },
        ),

        const SizedBox(height: 4),
       BlocBuilder<HealthRiskCubit, HealthRiskState>(
  builder: (context, state) {
    String text = "Loading...";
    if (state is HealthRiskSuccess) {
      text = state.risk;
      
    } else if (state is HealthRiskFailure) {
      text = "Error";
    }
    return Text(
      " HealthRisk • $text",
      style: TextStyle(color: AppColors.blueGrey),
    );
  },
),

      ],
    );
  }
}
