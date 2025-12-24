import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:dentiq/features/progress_tracker/presentation/progress_tracker_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
const HomeViewBody({super.key});

  final List<Map<String, String>> reminders = const [
    {"title": "Morning Brushing", "time": "08:00 AM"},
    {"title": "Flossing", "time": "08:30 AM"},
    {"title": "Evening Brushing", "time": "08:00 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),

          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,  
              enableInfiniteScroll: true,
            ),
            items: [
              buildCarouselCard(AppAssets.onboardingOne, "Keep Your Teeth Healthy!"),
              buildCarouselCard(AppAssets.tooth, "Don't Forget To Floss!"),
              buildCarouselCard(AppAssets.onboardingTwo, "Visit Your Dentist Regularly"),
            ],
          ),

          SizedBox(height: 20),

          // ===== Feature Grid =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                buildFeatureCard(
                  icon: Icons.alarm,
                  
                  title: "Reminders",
                  color: AppColors.primary!,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RemindersViewCreative()));
                  },
                ),
                buildFeatureCard(
                  icon: Icons.show_chart,
                  title: "Progress",
                  color: AppColors.primary!,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProgressView()));
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // ===== Today's Progress =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: AppColors.primary!.withOpacity(.6),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today's Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.whiteColor)),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.6,
                      color: AppColors.primary,
                      backgroundColor: AppColors.whiteColor.withOpacity(.7),
                      minHeight: 10,
                    ),
                    SizedBox(height: 5),
                    Text("60% Completed", style: TextStyle(color: AppColors.whiteColor)),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // ===== Reminders List =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Next Reminders", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                ...reminders.map((r) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        color: Colors.blue.shade50,
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.alarm, color: Colors.white),
                          ),
                          title: Text(r["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(r["time"]!, style: TextStyle(color: Colors.blueGrey)),
                        ),
                      ),
                    )),
              ],
            ),
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }

  // ===== Helper Widgets =====
Widget buildCarouselCard(String image, String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          // ===== الصورة =====
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),

          // ===== Overlay Gradient =====
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6), // أسود مع شفافية
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // ===== النص =====
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(1, 1),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget buildFeatureCard({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.whiteColor)),
          ],
        ),
      ),
    );
  }
}

// ===== Reminders Page (UI فقط) =====
class RemindersViewCreative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reminders")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add a Reminder", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            // اسم الريمندر
            TextField(
              decoration: InputDecoration(
                labelText: "Reminder Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 16),

            // اختيار الوقت (UI فقط)
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Time", style: TextStyle(fontSize: 16)),
                    Icon(Icons.access_time, color: Colors.blue),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("Add Reminder"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
