
  import 'package:flutter/material.dart';

class DotBuilder extends StatelessWidget {
  const DotBuilder({super.key, required this.index, required this.currentPage});
final int index;
final   int currentPage ;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue[900] : Colors.blue[200],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
  