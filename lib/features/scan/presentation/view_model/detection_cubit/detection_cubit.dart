import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/features/scan/data/model/local_model/local_model.dart';
import 'package:dentiq/features/scan/data/model/prediction_model.dart';
import 'package:dentiq/features/scan/data/repos/detection_repo.dart';
import 'package:dentiq/features/scan/data/repos/local_repo/local_repo.dart';
import 'package:dentiq/features/scan/data/repos/scan_repo/scan_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  DetectionCubit(this.repository, {required this.scanRepo, required this.localScanRepo}) : super(DetectionInitial());
  final DetectionRepository repository;
final ScanRepo scanRepo;
final LocalScanRepo localScanRepo;
  // Future<void> detect(File image) async {
  //   emit(DetectionLoading());

  //   final result = await repository.detect(image);

  //   result.fold(
  //     (fail) => emit(DetectionFailure(errorMessage:fail.message)),
  //     (prediction) async{
  //         final userId = getIt.get<FirebaseAuth>().currentUser!.uid;

  //     // await scanRepo.addScan(
  //     //   userId: userId,
  //     //   label: prediction.label,
  //     //   confidence: prediction.confidence,
  //     //   
  //     // );
  //       final imageUrl = await scanRepo.uploadUserScanImage(userId, image);

  //         await scanRepo.addScan(
  //           userId: userId,
  //           label: prediction.label,
  //           confidence: prediction.confidence,
  //           imageUrl: imageUrl!,
  //         );
  //        emit(DetectionSuccess(predictionModel:  prediction));
  //     },
  //   );
  // }
  Future<void> detect(File image) async {
  emit(DetectionLoading());

  final result = await repository.detect(image);

  result.fold(
    (fail) => emit(DetectionFailure(errorMessage: fail.message)),
    (prediction) async {
      
      emit(DetectionSuccess(predictionModel: prediction));

      final userId = getIt.get<FirebaseAuth>().currentUser!.uid;

      final localScan = LocalScanModel(
        label: prediction.label,
        confidence: prediction.confidence,
        imagePath: image.path,
        date: DateTime.now(),
      );

      await localScanRepo.saveScan(localScan);

      try {
        final imageUrl =
            await scanRepo.uploadUserScanImage(userId, image);

        await scanRepo.addScan(
          userId: userId,
          label: prediction.label,
          confidence: prediction.confidence,
          imageUrl: imageUrl!,
        );

        await localScanRepo.markAsSynced(localScan);
      } catch (_) {}
    },
  );
}
}
