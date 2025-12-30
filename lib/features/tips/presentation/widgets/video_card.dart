// import 'package:dentiq/core/utils/assets/app_assets.dart';
// import 'package:dentiq/features/tips/data/models/video_model.dart';
// import 'package:dentiq/features/tips/presentation/widgets/video_details.dart';
// import 'package:flutter/material.dart';

// class VideoCard extends StatelessWidget {
//   const VideoCard({super.key, required this.videoModel});
// final VideoModel videoModel;
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent, 
//       child: InkWell(
//         borderRadius: BorderRadius.circular(20),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const VideoDetailsView(),
//             ),
//           );
//         },
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 6),
//               )
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                   child: Stack(
//                     children: [
//                       Image.network(
//   videoModel.thumbnail.trim(), // ✅ .trim() يشيل الفراغات أو newlines
//   fit: BoxFit.cover,
//   width: double.infinity,
//   errorBuilder: (context, error, stackTrace) {
//     return Icon(Icons.error);
//   },
// )
// ,
//                       const Center(
//                         child: CircleAvatar(
//                           radius: 28,
//                           backgroundColor: Colors.white,
//                           child: Icon(Icons.play_arrow, size: 32),
//                         ),
//                       ),
//                        Positioned(
//                         bottom: 12,
//                         right: 12,
//                         child: Chip(label: Text(videoModel.duration)),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//                Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Text(
//                 videoModel.title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Text(
//                 videoModel.description,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dentiq/features/tips/data/models/video_model.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.videoModel});
  final VideoModel videoModel;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
initialVideoId: YoutubePlayer.convertUrlToId(widget.videoModel.videoUrl.trim())!,

      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(() {
        if (_isPlayerReady && mounted) {
          setState(() {
            _isPlaying = _controller.value.isPlaying;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_isPlayerReady) {
      setState(() {
        _isPlaying ? _controller.pause() : _controller.play();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: false,
                  onReady: () {
                    _isPlayerReady = true;
                  },
                ),
                if (!_isPlaying)
                  Positioned.fill(
                    child: Material(
                      color: Colors.black26,
                      child: InkWell(
                        onTap: _togglePlay,
                        child: const Center(
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: Icon( Icons.play_arrow, size: 32),
                          ),
                        ),
                      ),
                    ),
                  ),
            _isPlaying? SizedBox():    Positioned(
                  bottom: 12,
                  right: 12,
                  child: Chip(label: Text(widget.videoModel.duration)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.videoModel.title,
              style: AppStyle.text18.copyWith(color: AppColors.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Text(
              widget.videoModel.description,
              style: AppStyle.text16.copyWith(color: AppColors.blueGrey,fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
