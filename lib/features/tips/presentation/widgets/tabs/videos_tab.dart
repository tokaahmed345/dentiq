
import 'package:dentiq/features/tips/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';

class VideosTab extends StatelessWidget {
  const VideosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260, 
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (_, __) => const VideoCard(),
      ),
    );
  }
}