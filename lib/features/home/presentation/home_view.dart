import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/home/presentation/widgets/home_view_body.dart';
import 'package:dentiq/features/scan/presentation/scan_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeViewBody(),
ScanView(),
    Center(child: Text("Tips Page")),
    Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: const CustomAppBar(
        title: "DentIQ",
        subtitle: 'Your smile, our priority',
      ),
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
      color: Colors.blue[50],
          boxShadow: [
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
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.blue.shade800,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: [
            _buildAnimatedItem(Icons.home_outlined, Icons.home, 'Home', 0),
            _buildAnimatedItem(Icons.qr_code_scanner_outlined, Icons.qr_code_scanner, 'Scan', 1),
            _buildAnimatedItem(Icons.lightbulb_outline, Icons.lightbulb, 'Tips', 2),
            _buildAnimatedItem(Icons.person_outline, Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedItem(IconData icon, IconData activeIcon, String label, int index) {
    bool isActive = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedScale(
        scale: isActive ? 1.3 : 1.0, 
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Icon(isActive ? activeIcon : icon,size: 30,),
      ),
      label: label,
    );
  }
}

