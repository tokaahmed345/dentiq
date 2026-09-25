import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/scan/data/model/scan_history_model.dart';

abstract class ScanRepo {
   Future<Either<Failure, void>> addScan({
    required String userId,
    required String label,
    required double confidence,
    required String imageUrl
  });
    Future<Either<Failure, int>> getScanCount(String userId);
  Future<Either<Failure, Map<String, dynamic>>> getLastScan(String userId) ;
Future<Either<Failure, double>> getAverageConfidence(String userId) ;
Future<Either<Failure, List<ScanModel>>> getScanHistory(String userId);
  Future<String?> uploadUserScanImage(String userId, File file);

}