class DailyProgressModel {
  bool morningBrushing;
  bool eveningBrushing;
  bool flossing;
  bool mouthwash;

  DailyProgressModel({
    required this.morningBrushing,
    required this.eveningBrushing,
    required this.flossing,
    required this.mouthwash,
  });

  Map<String, dynamic> toJson() => {
        'morningBrushing': morningBrushing,
        'eveningBrushing': eveningBrushing,
        'flossing': flossing,
        'mouthwash': mouthwash,
      };

  factory DailyProgressModel.fromJson(Map<String, dynamic> json) =>
      DailyProgressModel(
        morningBrushing: json['morningBrushing'] ?? false,
        eveningBrushing: json['eveningBrushing'] ?? false,
        flossing: json['flossing'] ?? false,
        mouthwash: json['mouthwash'] ?? false,
      );
}
