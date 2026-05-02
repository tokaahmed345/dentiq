part of 'detection_cubit.dart';

sealed class DetectionState extends Equatable {
  const DetectionState();

  @override
  List<Object> get props => [];
}

final class DetectionInitial extends DetectionState {}
final class DetectionLoading extends DetectionState {}
final class DetectionSuccess extends DetectionState {
  final PredictionModel predictionModel;

  const DetectionSuccess({required this.predictionModel});
}
final class DetectionFailure extends DetectionState {
  final String errorMessage;

  const DetectionFailure({required this.errorMessage});
}
