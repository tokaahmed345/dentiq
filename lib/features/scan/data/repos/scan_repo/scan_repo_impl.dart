import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/scan/data/model/scan_history_model.dart';
import 'package:dentiq/features/scan/data/repos/scan_repo/scan_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScanRepoImpl implements ScanRepo {
  final FirebaseFirestore firestore;
  final SupabaseClient supabase;

  ScanRepoImpl(this.firestore, {required this.supabase});

  @override
  Future<Either<Failure, void>> addScan(
      {required String userId,
      required String label,
      required double confidence,
      required String imageUrl}) async {
    try {
      final snapshot = await firestore
          .collection("users")
          .doc(userId)
          .collection("scans")
          .add({
        "label": label,
        "confidence": confidence,
        "date": FieldValue.serverTimestamp(),
        "imageUrl": imageUrl,
      });
      return right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<String?> uploadUserScanImage(String userId, File file) async {
    try {
      final fileName =
          'scan_${DateTime.now().millisecondsSinceEpoch}_$userId.png';
      await supabase.storage.from('Scans').uploadBinary(
            fileName,
            await file.readAsBytes(),
            fileOptions: const FileOptions(upsert: true),
          );

      final publicUrl = supabase.storage.from('Scans').getPublicUrl(fileName);
      return '${publicUrl}?t=${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, int>> getScanCount(String userId) async {
    try {
      final snapshot = await firestore
          .collection("users")
          .doc(userId)
          .collection("scans")
          .get();

      return right(snapshot.docs.length);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getLastScan(
      String userId) async {
    try {
      final snapshot = await firestore
          .collection("users")
          .doc(userId)
          .collection("scans")
          .orderBy("date", descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return Right({});

      final data = snapshot.docs.first.data();
      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, double>> getAverageConfidence(String userId) async {
    try {
      final snapshot = await firestore
          .collection("users")
          .doc(userId)
          .collection("scans")
          .get();

      if (snapshot.docs.isEmpty) return right(0.0);

      double total = 0;
      for (var doc in snapshot.docs) {
        total += (doc['confidence'] as num).toDouble();
      }

      return right(total / snapshot.docs.length);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ScanModel>>> getScanHistory(String userId) async {
    try {
      final snapshot = await firestore
          .collection("users")
          .doc(userId)
          .collection("scans")
          .orderBy("date", descending: true)
          .get();

      final scans =
          snapshot.docs.map((doc) => ScanModel.fromJson(doc.data())).toList();

      return right(scans);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
