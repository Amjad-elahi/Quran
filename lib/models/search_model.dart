import 'package:quran/models/surah_model.dart';

class SearchModel {
  SearchModel({
    required this.count,
    required this.matches,
  });
  late final int count;
  late final List<Matches> matches;

  SearchModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    matches =
        List.from(json['matches']).map((e) => Matches.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['matches'] = matches.map((e) => e.toJson()).toList();
    return data;
  }
}

class Matches {
  Matches({
    required this.number,
    required this.text,
    required this.edition,
    required this.surah,
    required this.numberInSurah,
  });
  late final int number;
  late final String text;
  late final Edition edition;
  late final SurahModel surah;
  late final int numberInSurah;

  Matches.fromJson(Map<String, dynamic> json) {
    number = json['number'] ?? 0;
    text = json['text'] ?? '';
    edition = Edition.fromJson(json['edition'] ?? '');
    surah = SurahModel.fromJson(json['surah'] ?? '');
    numberInSurah = json['numberInSurah'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['number'] = number;
    data['text'] = text;
    data['edition'] = edition.toJson();
    data['surah'] = surah.toJson();
    data['numberInSurah'] = numberInSurah;
    return data;
  }

  @override
  String toString() {
    return 'Matches(text: $text, numberInSurah: $numberInSurah, )';
  }
}

class Edition {
  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.type,
  });
  late final String identifier;
  late final String language;
  late final String name;
  late final String englishName;
  late final String type;

  Edition.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['language'] = language;
    data['name'] = name;
    data['englishName'] = englishName;
    data['type'] = type;
    return data;
  }
}
