import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String id;
  final String title;
  final String videoUrl;
  final String thumbnail;
  final String duration;
  final String description;
  final String category;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.thumbnail,
    required this.duration,
    required this.description,
    required this.category,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json, String id) {
    return VideoModel(
      id: id,
      title: json['title'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}
