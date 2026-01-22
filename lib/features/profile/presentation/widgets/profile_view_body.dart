import 'dart:io';
import 'package:dentiq/features/profile/presentation/view_model/cubit/profile_info_cubit.dart';
import 'package:dentiq/features/profile/presentation/widgets/last_scan.dart';
import 'package:dentiq/features/profile/presentation/widgets/personal_info_card.dart';
import 'package:dentiq/features/profile/presentation/widgets/profile_header.dart';
import 'package:dentiq/features/profile/presentation/widgets/setting_section.dart';
import 'package:dentiq/features/profile/presentation/widgets/summary_row.dart';
import 'package:dentiq/features/profile/presentation/widgets/tips_profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// class ProfileViewBody extends StatefulWidget {
//   const ProfileViewBody({super.key});

//   @override
//   State<ProfileViewBody> createState() => _ProfileViewBodyState();
// }

// class _ProfileViewBodyState extends State<ProfileViewBody> {
//   File? pickedImage;
//   bool isEditing = false;
//   final TextEditingController password=TextEditingController();

//   Future<void> pickImage() async {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image != null) setState(() => pickedImage = File(image.path));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//           children: [
//             Header(),
//             const SizedBox(height: 20),
//             SummaryRow(),
//             const SizedBox(height: 24),
//             const LastScanCard(),
//             const SizedBox(height: 24),
//             TipsSectionProfile(),
//             const SizedBox(height: 24),
//             PersonalInfoCard(
//               isEditing: isEditing,
//               onToggle: () => setState(() => isEditing = !isEditing),
//               name:context.read<ProfileInfoCubit>().nameController,
//               phone:context.read<ProfileInfoCubit>().phoneController, 
//               email: context.read<ProfileInfoCubit>().emailController, password: password,

//             ),
//             const SizedBox(height: 24),
//             SettingsSection(),
//             const SizedBox(height: 40),
//           ],
//         ),
//       );
    
//   }
// }


class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? pickedImage;
  bool isEditing = false;
  final TextEditingController password = TextEditingController();
  final TextEditingController oldPassword = TextEditingController();

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => pickedImage = File(image.path));
  }

  void _toggleEdit(BuildContext context) {
    if (isEditing) {
      final cubit = context.read<ProfileInfoCubit>();
      cubit.updateProfile(
        name: cubit.nameController.text,
        phone: cubit.phoneController.text,
        email: cubit.emailController.text,
        password: password.text.isNotEmpty ? password.text : null,
        oldPassword: oldPassword.text,
      );
    }
    setState(() => isEditing = !isEditing);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
      listener: (context, state) {
        if (state is ProfileInfoFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is ProfileInfoUpdateSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProfileInfoCubit>();
        return SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 20),
              const SummaryRow(),
              const SizedBox(height: 24),
              const LastScanCard(),
              const SizedBox(height: 24),
              const TipsSectionProfile(),
              const SizedBox(height: 24),
              PersonalInfoCard(
                isEditing: isEditing,
                onToggle: () => _toggleEdit(context),
                name: cubit.nameController,
                phone: cubit.phoneController,
                email: cubit.emailController,
                password: password,
                oldPassword: oldPassword,
              ),
              const SizedBox(height: 24),
              const SettingsSection(),
              const SizedBox(height: 40),
              if (state is ProfileInfoLoading) const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    password.dispose();
    oldPassword.dispose();
    super.dispose();
  }
}
