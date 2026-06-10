import 'package:quranify/lib.dart';

class SurahModel extends QuranModel {
  final List<AyahModel> ayahs;

  SurahModel({
    super.number,
    required super.name,
    required super.nameTranslation,
    super.numberOfAyat,
    required super.relevationType,
    required this.ayahs,
  });

  factory SurahModel.fromEditionJson(List<dynamic> data) {
    final arabic = data[0];
    final translation = data[1];

    final arabicAyahs = arabic['ayahs'] as List<dynamic>;

    final translationAyahs = translation['ayahs'] as List<dynamic>;

    return SurahModel(
      number: arabic['number'],
      name: arabic['englishName'],
      nameTranslation: arabic['englishNameTranslation'],
      numberOfAyat: arabic['numberOfAyahs'],
      relevationType: arabic['revelationType'],
      ayahs: List.generate(
        arabicAyahs.length,
        (index) => AyahModel.fromCombinedJson(
          arabic: arabicAyahs[index],
          translation: translationAyahs[index],
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'englishName': name,
      'englishNameTranslation': nameTranslation,
      'numberOfAyahs': numberOfAyat,
      'revelationType': relevationType,
      'ayahs': ayahs.map((e) => e.toJson()).toList(),
    };
  }

  @override
  SurahEntity toEntity() {
    return SurahEntity(
      number: number,
      name: name,
      nameTranslation: nameTranslation,
      numberOfAyat: numberOfAyat,
      relevationType: relevationType,
      ayahs: ayahs.map((e) => e.toEntity()).toList(),
    );
  }
}

class AyahModel {
  final int number;
  final int numberInSurah;
  final int juz;
  final int page;

  final String arabicText;
  final String translationText;

  AyahModel({
    required this.number,
    required this.numberInSurah,
    required this.juz,
    required this.page,
    required this.arabicText,
    required this.translationText,
  });

  factory AyahModel.fromCombinedJson({
    required Map<String, dynamic> arabic,
    required Map<String, dynamic> translation,
  }) {
    return AyahModel(
      number: arabic['number'],
      numberInSurah: arabic['numberInSurah'],
      juz: arabic['juz'],
      page: arabic['page'],
      arabicText: arabic['text'],
      translationText: translation['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'page': page,
      'arabicText': arabicText,
      'translationText': translationText,
    };
  }

  AyahEntity toEntity() {
    return AyahEntity(
      number: number,
      numberInSurah: numberInSurah,
      juz: juz,
      page: page,
      arabicText: arabicText,
      translationText: translationText,
    );
  }
}
