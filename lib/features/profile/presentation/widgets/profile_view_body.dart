import 'dart:io';
import 'package:dentiq/features/profile/presentation/widgets/last_scan.dart';
import 'package:dentiq/features/profile/presentation/widgets/personal_info_card.dart';
import 'package:dentiq/features/profile/presentation/widgets/profile_header.dart';
import 'package:dentiq/features/profile/presentation/widgets/setting_section.dart';
import 'package:dentiq/features/profile/presentation/widgets/summary_row.dart';
import 'package:dentiq/features/profile/presentation/widgets/tips_profile_section.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? pickedImage;
  bool isEditing = false;

  final nameController = TextEditingController(text: "Sarah Johnson");
  final phoneController = TextEditingController(text: "+20123456789");
  final emailController = TextEditingController(text: "sarah@mail.com");
  final passwordController = TextEditingController();





  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => pickedImage = File(image.path));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            const SizedBox(height: 20),
            SummaryRow(),
            const SizedBox(height: 24),
            const LastScanCard(),
            const SizedBox(height: 24),
            TipsSectionProfile(),
            const SizedBox(height: 24),
            PersonalInfoCard(
              isEditing: isEditing,
              onToggle: () => setState(() => isEditing = !isEditing),
              name: nameController,
              phone: phoneController,
              email: emailController,
              password: passwordController,
            ),
            const SizedBox(height: 24),
            SettingsSection(),
            const SizedBox(height: 40),
          ],
        ),
      );
    
  }
}


