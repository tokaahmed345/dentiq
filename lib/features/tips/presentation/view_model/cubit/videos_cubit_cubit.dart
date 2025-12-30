import 'package:bloc/bloc.dart';
import 'package:dentiq/features/tips/data/models/video_model.dart';
import 'package:dentiq/features/tips/data/repo/video_repo.dart';
import 'package:equatable/equatable.dart';

part 'videos_cubit_state.dart';

class VideosCubit extends Cubit<VideosCubitState> {
  VideosCubit(this.videoRepo) : super(VideosCubitInitial());
  final VideoRepo videoRepo;
 
  Future<void> getVideos() async {
    emit(VideosCubitLoading());

    final result = await videoRepo.getAllVideos();

    result.fold(
      (failure) => emit(VideosCubitFailure(errorMessage:  failure.message)),
      (success) => emit(VideosCubitSuccess(videos: success)),
    );
  } 
}
