// Converting API data into a structured format for easy manipulation
class SurahModel {
  SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });
  late final int number;
  late final String name;
  late final String englishName;
  late final String englishNameTranslation;
  late final int numberOfAyahs;
  late final String revelationType;

  SurahModel.fromJson(Map<String, dynamic> json) {
    number = json['number'] ?? 0;
    name = json['name'] ?? '';
    englishName = json['englishName'] ?? '';
    englishNameTranslation = json['englishNameTranslation'] ?? '';
    numberOfAyahs = json['numberOfAyahs'] ?? 0;
    revelationType = json['revelationType'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['englishNameTranslation'] = englishNameTranslation;
    data['numberOfAyahs'] = numberOfAyahs;
    data['revelationType'] = revelationType;
    return data;
  }

  @override
  String toString() {
    return 'SurahModel(englishName: $englishName, number: $number)';
  }
}
