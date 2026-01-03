import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/home/presentation/widgets/home_view_body.dart';
import 'package:dentiq/features/profile/profile_view.dart';
import 'package:dentiq/features/scan/presentation/scan_view.dart';
import 'package:dentiq/features/tips/presentation/tips_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeViewBody(),
    ScanView(),
    TipsView(),
    ProfileView()
  ];

  PreferredSizeWidget? _buildAppBar() {
    switch (_currentIndex) {
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
          onNotificationTap: () {},
          suffixIcon: Icons.notifications_outlined,
        );

      case 1:
        return CustomAppBar(
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: _buildAppBar(),
        body: SafeArea(child: _pages[_currentIndex]),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
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
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
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
    bool isActive = _currentIndex == index;
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
