import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/failure.dart';
import 'package:dentiq/features/scan/data/model/diseases_model.dart';
import 'package:dentiq/features/scan/data/repos/diseases_repo/diseases_repo.dart';
import 'package:flutter/foundation.dart';

class DiseaseRepoImpl implements DiseaseRepo {
  final FirebaseFirestore firestore;

  DiseaseRepoImpl(this.firestore);

  @override
  Future<Either<Failure, DiseaseModel>> getDiseaseById(String diseaseLabel) async {
    try {
      debugPrint('Fetching disease: $diseaseLabel');

      final querySnapshot = await firestore
          .collection('diseases')
          .where('name', isEqualTo: diseaseLabel.trim())
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return left(Failure('Disease not found'));
      }

      final doc = querySnapshot.docs.first;
      debugPrint('Document found: ${doc.id}');
      debugPrint('Document data: ${doc.data()}');

      final disease = DiseaseModel.fromJson(doc.data());
      return right(disease);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? 'Firebase error'));
    } catch (e) {
      return left(Failure('Unexpected error'));
    }
  }
}
