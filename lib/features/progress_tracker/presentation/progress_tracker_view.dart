
import 'package:dentiq/core/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  final Map<String, bool> routinesDone = {
    "Morning Brushing": false,
    "Flossing": false,
    "Evening Brushing": false,
    "Mouthwash": false,
  };

  double get overallProgress {
    if (routinesDone.isEmpty) return 0;
    int completed = routinesDone.values.where((done) => done).length;
    return completed / routinesDone.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:     Colors.blue[50],
 
      appBar: CustomAppBar(title: "progress"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ===== Overall Progress Card =====
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.blue.shade50,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Overall Progress",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                    SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: overallProgress,
                      color: Colors.blue,
                      backgroundColor: Colors.blue.shade100,
                      minHeight: 14,
                    ),
                    SizedBox(height: 8),
                    Text("${(overallProgress * 100).toInt()}% Completed",
                        style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // ===== Individual Routines Cards =====
            Expanded(
              child: ListView(
                children: routinesDone.entries.map((entry) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                          Checkbox(
                            value: entry.value,
                            activeColor: Colors.blue,
                            onChanged: (checked) {
                              setState(() {
                                routinesDone[entry.key] = checked ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
