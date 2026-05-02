import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/tips/data/models/video_model.dart';
import 'package:dentiq/features/tips/data/repo/video_repo/video_repo.dart';

class VideoRepoImpl extends VideoRepo {
  final FirebaseFirestore firebaseFirestore;

 VideoRepoImpl ({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, List<VideoModel>>>getAllVideos() async {
    try {
final snapshot= await firebaseFirestore
        .collection('tips_videos')
        .orderBy('createdAt', descending: true)
        .get();
         final videos = snapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data(), doc.id))
        .toList();
     return right(videos);
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}
