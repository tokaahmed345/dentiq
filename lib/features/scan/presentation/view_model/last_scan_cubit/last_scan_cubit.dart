import 'package:bloc/bloc.dart';
import 'package:dentiq/features/scan/data/repos/scan_repo/scan_repo.dart';
import 'package:equatable/equatable.dart';

part 'last_scan_state.dart';

class LastScanCubit extends Cubit<LastScanState> {
  LastScanCubit(this.scanRepo) : super(LastScanInitial());
  final ScanRepo scanRepo;
Future<void> fetchLastScan(String userId) async {
  emit(ScanLastLoading());

  final result = await scanRepo.getLastScan(userId);

  result.fold(
    (failure) => emit(ScanLastFailure(failure.message)),
    (data) => emit(ScanLastSuccess(data)),
  );
}

}
