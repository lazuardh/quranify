class QuranEntity {
  final int? number;
  final String name;
  final String nameTranslation;
  final int? numberOfAyat;
  final String relevationType;

  QuranEntity({
    this.number,
    required this.name,
    required this.nameTranslation,
    this.numberOfAyat,
    required this.relevationType,
  });
}
