part of 'videos_cubit_cubit.dart';

sealed class VideosCubitState extends Equatable {
  const VideosCubitState();

  @override
  List<Object> get props => [];
}

final class VideosCubitInitial extends VideosCubitState {}
final class VideosCubitLoading extends VideosCubitState {}
final class VideosCubitSuccess extends VideosCubitState {
  final List<VideoModel>videos;

  const VideosCubitSuccess({required this.videos});
    @override
  List<Object> get props => [videos];
}
final class VideosCubitFailure extends VideosCubitState {
  final String errorMessage;

  const VideosCubitFailure({required this.errorMessage});
    @override
  List<Object> get props => [];
}
