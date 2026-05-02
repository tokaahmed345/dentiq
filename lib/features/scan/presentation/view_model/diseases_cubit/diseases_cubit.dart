import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/scan/data/model/diseases_model.dart';
import 'package:dentiq/features/scan/data/repos/diseases_repo/diseases_repo_impl.dart';
import 'package:dentiq/features/scan/data/repos/diseases_repo/diseases_repo.dart';
import 'package:equatable/equatable.dart';

part 'diseases_state.dart';

class DiseasesCubit extends Cubit<DiseasesState> {
  final DiseaseRepo repo;

  DiseasesCubit(this.repo) : super(DiseasesInitial());

  Future<void> fetchDiseaseTips(String diseaseLabel) async {
    emit(DiseasesLoading());

    try {
      final Either<Failure, DiseaseModel> result =
          await repo.getDiseaseById(diseaseLabel);

      result.fold(
        (failure) => emit(DiseasesError(failure.message)),
        (disease) => emit(DiseasesLoaded(disease)),
      );
    } catch (e) {
      emit(DiseasesError(e.toString()));
    }
  }
}
