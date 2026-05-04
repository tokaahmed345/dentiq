import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/scan/data/model/scan_history_model.dart';
import 'package:dentiq/features/scan/data/repos/local_repo/local_repo.dart';
import 'package:dentiq/features/scan/data/repos/scan_repo/scan_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'scan_history_state.dart';

class ScanHistoryCubit extends Cubit<ScanHistoryState> {
  ScanHistoryCubit(this.repo, this.localRepo)
      : super(ScanHistoryInitial());

  final ScanRepo repo;
  final LocalScanRepo localRepo;

  Future<void> getHistory() async {
    emit(ScanHistoryLoading());

    final userId = getIt.get<FirebaseAuth>().currentUser!.uid;

    await _syncScans(userId);

    List<ScanModel> all = [];

    final localScans = localRepo.getScans()
        .where((e) => !e.isSynced)
        .map((e) => ScanModel(
              label: e.label,
              confidence: e.confidence,
              imageUrl: e.imagePath,
              date: e.date,
            ))
        .toList();

    all.addAll(localScans);

    final result = await repo.getScanHistory(userId);

    result.fold(
      (fail) => emit(ScanHistoryFailure(fail.message)),
      (remoteScans) {
        all.addAll(remoteScans);

        all.sort((a, b) => b.date.compareTo(a.date));

        emit(ScanHistorySuccess(all));
      },
    );
  }

  Future<void> _syncScans(String userId) async {
    final unsynced = localRepo.getUnsyncedScans();

    for (var scan in unsynced) {
      try {
        final imageUrl = await repo.uploadUserScanImage(
          userId,
          File(scan.imagePath),
        );

        await repo.addScan(
          userId: userId,
          label: scan.label,
          confidence: scan.confidence,
          imageUrl: imageUrl!,
        );

        await localRepo.markAsSynced(scan);
      } catch (_) {}
    }
  }
}