class DailyProgressModel {
  bool morningBrushing;
  bool eveningBrushing;
  bool flossing;
  bool mouthwash;
  bool drinkWater;
  bool healthyMeals;
  bool tongueCleaning;
  bool checkGums;

  DailyProgressModel({
    this.morningBrushing = false,
    this.eveningBrushing = false,
    this.flossing = false,
    this.mouthwash = false,
    this.drinkWater = false,
    this.healthyMeals = false,
    this.tongueCleaning = false,
    this.checkGums = false,
  });

  Map<String, dynamic> toJson() => {
        'morningBrushing': morningBrushing,
        'eveningBrushing': eveningBrushing,
        'flossing': flossing,
        'mouthwash': mouthwash,
        'drinkWater': drinkWater,
        'healthyMeals': healthyMeals,
        'tongueCleaning': tongueCleaning,
        'checkGums': checkGums,
      };

  factory DailyProgressModel.fromJson(Map<String, dynamic> json) =>
      DailyProgressModel(
        morningBrushing: json['morningBrushing'] ?? false,
        eveningBrushing: json['eveningBrushing'] ?? false,
        flossing: json['flossing'] ?? false,
        mouthwash: json['mouthwash'] ?? false,
        drinkWater: json['drinkWater'] ?? false,
        healthyMeals: json['healthyMeals'] ?? false,
        tongueCleaning: json['tongueCleaning'] ?? false,
        checkGums: json['checkGums'] ?? false,
      );
}
