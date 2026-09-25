
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/tips/data/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoModel;
  const VideoCard({super.key, required this.videoModel});

  void openYoutube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openYoutube(videoModel.videoUrl);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    videoModel.thumbnail.trim(),
                    height: 230,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 230,
                        color: Colors.grey[300],
                        child: const Icon(Icons.play_circle_outline, size: 60),
                      );
                    },
                  ),
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.play_arrow, size: 34),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Chip(label: Text(videoModel.duration)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                videoModel.title,
                style: AppStyle.text18.copyWith(color: AppColors.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Text(
                videoModel.description,
                style: AppStyle.text16.copyWith(
                  color: AppColors.blueGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
