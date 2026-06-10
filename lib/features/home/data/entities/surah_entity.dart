import 'package:quranify/lib.dart';

class SurahEntity extends QuranEntity {
  List<AyahEntity> ayahs;

  SurahEntity({
    super.number,
    required super.name,
    required super.nameTranslation,
    super.numberOfAyat,
    required super.relevationType,
    required this.ayahs,
  });
}

class AyahEntity {
  final int number;
  final int numberInSurah;
  final int juz;
  final int page;

  final String arabicText;
  final String translationText;

  AyahEntity({
    required this.number,
    required this.numberInSurah,
    required this.juz,
    required this.page,
    required this.arabicText,
    required this.translationText,
  });
}
