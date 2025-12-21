import 'dart:io';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? pickedImage;
  bool isEditing = false;

  final List<String> tips = [
    "Brush twice daily",
    "Floss regularly",
  ];

  final nameController = TextEditingController(text: "Sarah Johnson");
  final phoneController = TextEditingController(text: "+20123456789");
  final emailController = TextEditingController(text: "sarah@mail.com");
  final passwordController = TextEditingController();

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            
            onPressed: () => Navigator.pop(context),
            child:  Text("Cancel",style: TextStyle(color: AppColors.primary),),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.whiteColor,
              backgroundColor:AppColors.primary,
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
             _Header(
              imageFile: pickedImage,
              onImageTap: pickImage,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                const _Summary(),
                const SizedBox(height: 24),
                const _LastScan(),
                const SizedBox(height: 24),
                _Tips(tips: tips),
                const SizedBox(height: 24),
                _PersonalInfoCard(
                  isEditing: isEditing,
                  onEditToggle: () {
                    setState(() => isEditing = !isEditing);
                  },
                  nameController: nameController,
                  phoneController: phoneController,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 24),
                _Settings(
                  onLogoutTap: () => _showLogoutDialog(context),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HEADER =================
class _Header extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onImageTap;

  const _Header({required this.imageFile, required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          GestureDetector(
            onTap: onImageTap,
            child: CircleAvatar(
              radius: 42,
              backgroundImage: imageFile != null
                  ? FileImage(imageFile!)
                  : const NetworkImage('https://i.pravatar.cc/300')
                      as ImageProvider,
              child: const Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.camera_alt, size: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Sarah Johnson",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Oral Health • Good",
            style: TextStyle(fontSize: 13, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}

// ================= SUMMARY =================
class _Summary extends StatelessWidget {
  const _Summary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _SummaryItem(title: "Scans", value: "24"),
          _SummaryItem(title: "Score", value: "85%"),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// ================= LAST SCAN =================
class _LastScan extends StatelessWidget {
  const _LastScan();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Row(
          children: [
            Icon(Icons.medical_services, color: Colors.teal),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Scan Result",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Healthy • 92%",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Dec 15",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= TIPS =================
class _Tips extends StatelessWidget {
  final List<String> tips;
  const _Tips({required this.tips});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tips for you",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...tips.map(
            (tip) => Text(
              "• $tip",
              style: const TextStyle(color: Colors.grey, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= PERSONAL INFO CARD =================
class _PersonalInfoCard extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onEditToggle;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _PersonalInfoCard({
    required this.isEditing,
    required this.onEditToggle,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:   Colors.white60,

          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  "Personal Info",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit),
                  onPressed: onEditToggle,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _field("Name", nameController, enabled: isEditing),
            _field("Phone", phoneController, enabled: isEditing),
            _field("Email", emailController, enabled: isEditing),
            if (isEditing)
              _field("New Password", passwordController,
                  enabled: isEditing, obscure: true),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller,
      {bool enabled = false, bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

// ================= SETTINGS =================
class _Settings extends StatelessWidget {
  final VoidCallback onLogoutTap;

  const _Settings({required this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SettingRow(
          icon: Icons.notifications_outlined,
          title: "Reminders",
        ),
        _SettingRow(
          icon: Icons.logout,
          title: "Logout",

          isLogout: true,
          onTap: onLogoutTap,
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final VoidCallback? onTap;

  const _SettingRow({
    required this.icon,
    required this.title,
    this.isLogout = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isLogout ?  AppColors.primary : Colors.teal,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? AppColors.primary : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
