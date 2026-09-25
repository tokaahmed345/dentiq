part of 'diseases_cubit.dart';


sealed class DiseasesState extends Equatable {
  const DiseasesState();

  @override
  List<Object?> get props => [];
}

class DiseasesInitial extends DiseasesState {}

class DiseasesLoading extends DiseasesState {}

class DiseasesLoaded extends DiseasesState {
  final DiseaseModel disease;
  const DiseasesLoaded(this.disease);

  @override
  List<Object?> get props => [disease];
}

class DiseasesError extends DiseasesState {
  final String message;
  const DiseasesError(this.message);

  @override
  List<Object?> get props => [message];
}
