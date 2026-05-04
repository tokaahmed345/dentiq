
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/tips/presentation/view_model/videos_cubit/videos_cubit_cubit.dart';
import 'package:dentiq/features/tips/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class VideosTab extends StatelessWidget {
  const VideosTab({super.key});

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.grey[300], 
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 16,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey[300],
          ),
          const SizedBox(height: 8),
          Container(
            height: 14,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey[300],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideosCubit, VideosCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is VideosCubitSuccess) {
          final res = state.videos;
          return SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: res.length,
              itemBuilder: (context, index) {
                final video = res[index];
                return VideoCard(videoModel: video);
              },
            ),
          );
        } else if (state is VideosCubitFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          return SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              
              itemCount: 3, 
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: AppColors.primary!.withOpacity(.1),  
                  highlightColor: AppColors.primary!.withOpacity(.2), 
                  child: _buildShimmerCard(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
