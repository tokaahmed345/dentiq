import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onToggle;

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController oldPassword;


  const PersonalInfoCard({
    super.key,
    required this.isEditing,
    required this.onToggle,
    required this.name,
    required this.phone,
    required this.email,
    required this.password, required this.oldPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Personal Info",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onToggle,
                  icon: Icon(
                    isEditing ? Icons.check : Icons.edit,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          CustomFormField(hint: 'Name', controller: name,enabled: isEditing,),
          const SizedBox(height: 20,),
          CustomFormField(hint: 'Phone', controller: phone,enabled: isEditing,),
                    const SizedBox(height: 20,),

                    CustomFormField(hint: 'Email', controller: email,enabled: isEditing,),

                    const SizedBox(height: 20,),

 if (isEditing) ...[
              CustomFormField(hint: 'Old Password', controller: oldPassword), // جديد
              const SizedBox(height: 20),
              CustomFormField(hint: 'New Password', controller: password),
            ],
          ],
        ),
      ),
    );
  }




}
