import 'package:dentiq/features/scan/data/model/local_model/local_model.dart';
import 'package:hive/hive.dart';

class LocalScanRepo {
  final box = Hive.box<LocalScanModel>('scans');

  Future<void> saveScan(LocalScanModel scan) async {
    await box.add(scan);
  }

  List<LocalScanModel> getScans() {
    return box.values.toList();
  }

  List<LocalScanModel> getUnsyncedScans() {
    return box.values.where((e) => !e.isSynced).toList();
  }

  Future<void> markAsSynced(LocalScanModel scan) async {
    scan.isSynced = true;
    await scan.save();
  }
}