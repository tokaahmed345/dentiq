import 'package:hive/hive.dart';

part 'local_model.g.dart';

@HiveType(typeId: 0)
class LocalScanModel extends HiveObject {
  @HiveField(0)
  String label;

  @HiveField(1)
  double confidence;

  @HiveField(2)
  String imagePath;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  bool isSynced;

  LocalScanModel({
    required this.label,
    required this.confidence,
    required this.imagePath,
    required this.date,
    this.isSynced = false,
  });
}