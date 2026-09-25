import 'package:cloud_firestore/cloud_firestore.dart';

class ScanModel {
  final String label;
  final double confidence;
  final DateTime date;
    final String imageUrl;


  ScanModel({
    required this.label,
    required this.confidence,
    required this.date, required this.imageUrl,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      label: json['label'],
      confidence: (json['confidence'] as num).toDouble(),
      date: (json['date'] as Timestamp).toDate(), imageUrl:json['imageUrl']??"",
    );
  }
}