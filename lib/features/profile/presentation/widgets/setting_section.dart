import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/router/routes_name.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/core/utils/sharedprefrence.dart';
import 'package:dentiq/features/auth/presentation/view_model/log_out_cubit/log_out_cubit.dart';
import 'package:dentiq/features/reminder/presentation/widgets/reminder_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _SettingTile(
              icon: Icons.notifications,
              title: "Reminders",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ReminderHistoryPage(),
                  ),
                );
              }),
          BlocProvider(
            create: (context) => getIt.get<LogOutCubit>(),
            child: BlocConsumer<LogOutCubit, LogOutState>(
              listener: (context, state) {
                if (state is LogOutFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)));
                } else if (state is LogOutSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')));
                  GoRouter.of(context).go(RoutesName.logIn);
                }
              },
              builder: (context, state) {
                if (state is LogOutLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    ),
                  );
                } else {
                  return _SettingTile(
                    icon: Icons.logout,
                    title: "Logout",
                    danger: true,
                    onTap: () => _showLogoutDialog(context),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: AppColors.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await getIt<SharedPrefs>().clearAll();
              context.read<LogOutCubit>().logOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool danger;
  final VoidCallback? onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    this.danger = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: AppColors.primary!.withOpacity(0.1),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: danger ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
