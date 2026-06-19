class BookmarkEntity {
  final int number;
  final String name;
  final String arabicText;
  final String translationText;
  final int ayahNumber;
  final DateTime createdAt;

  const BookmarkEntity({
    required this.number,
    required this.name,
    required this.arabicText,
    required this.translationText,
    required this.ayahNumber,
    required this.createdAt,
  });
}
