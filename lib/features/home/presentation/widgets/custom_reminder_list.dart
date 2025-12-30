import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRemiderList extends StatelessWidget {
  const CustomRemiderList({
    super.key,
    required this.reminders,
  });

  final List<Map<String, String>> reminders;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
