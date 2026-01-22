import 'dart:io';
import 'package:dentiq/features/profile/presentation/view_model/cubit/profile_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return BlocBuilder<ProfileHeaderCubit, ProfileHeaderState>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
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
                    child:CircleAvatar(
  radius: 52,
  backgroundColor: Colors.grey.shade200,
  backgroundImage: state.localImage != null
      ? FileImage(state.localImage!)
      : (state.imageUrl != null
          ? NetworkImage(state.imageUrl!)
          : null),
  child: state.localImage == null && state.imageUrl == null
      ? const Icon(
          Icons.person,
          size: 48,
          color: Colors.grey,
        )
      : null,
)

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
            ),
            const SizedBox(height: 12),
            Text(
             state.userName??"",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Oral Health • Good",
              style: TextStyle(color: AppColors.blueGrey),
            ),
          ],
        );
      },
    );
  }
}
