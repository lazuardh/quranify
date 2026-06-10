import 'package:quranify/lib.dart';

class QuranModel {
  int? number;
  String name;
  String nameTranslation;
  int? numberOfAyat;
  String relevationType;

  QuranModel({
    this.number,
    required this.name,
    required this.nameTranslation,
    this.numberOfAyat,
    required this.relevationType,
  });

  factory QuranModel.fromJson(Map<String, dynamic> json) {
    return QuranModel(
      number: json['number'] == null ? null : json['number'] as int?,
      name: json['englishName'],
      nameTranslation: json['englishNameTranslation'],
      numberOfAyat: json['numberOfAyahs'] == null
          ? null
          : json['numberOfAyahs'] as int?,
      relevationType: json['revelationType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'englishName': name,
      'englishNameTranslation': nameTranslation,
      'numberOfAyahs': numberOfAyat,
      'revelationType': relevationType,
    };
  }

  QuranEntity toEntity() {
    return QuranEntity(
      number: number,
      name: name,
      nameTranslation: nameTranslation,
      numberOfAyat: numberOfAyat,
      relevationType: relevationType,
    );
  }
}
