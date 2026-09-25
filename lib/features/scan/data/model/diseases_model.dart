class DiseaseModel {
  final String name;
  final List<String> tips;

  DiseaseModel({
    required this.name,
    required this.tips,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      name: json['name'],
      tips: List<String>.from(json['tips']),
    );
  }
}
