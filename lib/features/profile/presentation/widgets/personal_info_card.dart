import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onToggle;

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;

  const PersonalInfoCard({
    super.key,
    required this.isEditing,
    required this.onToggle,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
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
            _field("Name", name, isEditing),
            _field("Phone", phone, isEditing),
            _field("Email", email, isEditing),
            if (isEditing) _field("New Password", password, true, true),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller,
    bool enabled, [
    bool obscure = false,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: enabled ? const Color(0xffF6F8FB) : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
