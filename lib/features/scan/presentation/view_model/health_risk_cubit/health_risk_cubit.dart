import 'package:bloc/bloc.dart';
import 'package:dentiq/features/scan/data/repos/scan_repo/scan_repo.dart';
import 'package:equatable/equatable.dart';

part 'health_risk_state.dart';

class HealthRiskCubit extends Cubit<HealthRiskState> {
  HealthRiskCubit(this.scanRepo) : super(HealthRiskInitial());
  final ScanRepo scanRepo;


  Future<void> fetchHealthRisk(String userId) async {
    emit(HealthRiskLoading());

    final result = await scanRepo.getAverageConfidence(userId);

    result.fold(
      (failure) => emit(HealthRiskFailure(failure.message)),
      (avg) {
       
 



        String risk;
        if (avg == 0) {
  risk = "No scans yet";
        } else if (avg >= 0.75) {
          risk = "High";
        } else if (avg >= 0.4) {
          risk = "Medium";
        } else  {
          risk = "Low";
        }
        

        emit(HealthRiskSuccess(avg, risk));
      },
    );
  }
}
