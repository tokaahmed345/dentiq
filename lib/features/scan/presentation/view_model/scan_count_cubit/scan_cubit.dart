import 'package:bloc/bloc.dart';
import 'package:dentiq/features/scan/data/repos/scan_repo/scan_repo.dart';
import 'package:equatable/equatable.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit(this.scanRepo) : super(ScanInitial());
    final ScanRepo scanRepo;


  Future<void> fetchScanCount(String userId) async {
    emit(ScanCountLoading());

    final result = await scanRepo.getScanCount(userId);

    result.fold(
      (failure) => emit(ScanCountFailure(failure.message)),
      (count) => emit(ScanCountSuccess(count)),
    );
  }
}
