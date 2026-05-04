import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/chat/presentation/chat_view.dart';
import 'package:dentiq/features/home/presentation/widgets/home_view_body.dart';
import 'package:dentiq/features/profile/presentation/profile_view.dart';
import 'package:dentiq/features/reminder/presentation/view_model/cubit/dental_reminder_cubit.dart';
import 'package:dentiq/features/scan/presentation/scan_view.dart';
import 'package:dentiq/features/tips/presentation/tips_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> _pages = const [
    HomeViewBody(),
    ScanView(),
    TipsView(),
    ProfileView()
  ];

  PreferredSizeWidget? _buildAppBar() {
    switch (currentIndex) {
      case 2:
        return const CustomAppBar(
          title: "Dental Tips",
          subtitle: "Daily care tips",
          bottom: TipsTabs(),
        );

      case 0:
        return CustomAppBar(
          title: "DentIQ",
          subtitle: "Your smile, our priority",
          onNotificationTap: () {

          },
    suffixIconWidget: notificationIcon(context), 
        );

      case 1:
        return const CustomAppBar(
          title: "Teeth Scan",
        );

      case 3:
        return const CustomAppBar(
          title: "Profile",
          subtitle: "Your personal info",
        );

      default:
        return null;
    }
  }
  
 @override
  void initState() {
    super.initState();
    if (currentIndex == 0) {
      context.read<DentalReminderCubit>().fetchUpcomingReminders();

    }
    
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(),
        body: SafeArea(child: _pages[currentIndex]),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }
Widget notificationIcon(BuildContext context) {

  return Stack(
    children: [
      IconButton(
        icon: const Icon(Icons.message),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatView()),
          );
          
        },
      ),
     
    ],
  );
}

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
           if (index == 0) {
      context.read<DentalReminderCubit>().fetchUpcomingReminders();
    }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.grey,
        items: [
          _buildAnimatedItem(Icons.home_outlined, Icons.home, 'Home', 0),
          _buildAnimatedItem(
              Icons.qr_code_scanner_outlined, Icons.qr_code_scanner, 'Scan', 1),
          _buildAnimatedItem(
              Icons.lightbulb_outline, Icons.lightbulb, 'Tips', 2),
          _buildAnimatedItem(Icons.person_outline, Icons.person, 'Profile', 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    bool isActive = currentIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedScale(
        scale: isActive ? 1.3 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Icon(isActive ? activeIcon : icon, size: 30),
      ),
      label: label,
    );
  }
}

class TipsTabs extends StatelessWidget implements PreferredSizeWidget {
  const TipsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      child: TabBar(
        onTap: (index) {
          // index 0 = Videos, 1 = Articles, 2 = Guidelines
          // if (index == 1) {
          //   context.read<ArticlesCubit>().getArticles();
          // }   if (index == 0) {
          //   context.read<VideosCubit>().getVideos();
          // }
        },
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.white,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: 'Videos'),
          Tab(text: 'Articles'),
          Tab(text: 'Guidelines'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
