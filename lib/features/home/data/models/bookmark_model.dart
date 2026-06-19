import '../../../../lib.dart';

class BookmarkModel {
  final int number;
  final String name;
  final String arabicText;
  final String translationText;
  final int ayahNumber;
  final DateTime createdAt;

  const BookmarkModel({
    required this.number,
    required this.name,
    required this.arabicText,
    required this.translationText,
    required this.ayahNumber,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'arabicText': arabicText,
      'translationText': translationText,
      'ayahNumber': ayahNumber,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BookmarkModel.create({
    required int number,
    required String name,
    required String arabicText,
    required String translationText,
    required int ayahNumber,
  }) {
    return BookmarkModel(
      number: number,
      name: name,
      arabicText: arabicText,
      translationText: translationText,
      ayahNumber: ayahNumber,
      createdAt: DateTime.now(),
    );
  }

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      number: json['number'],
      name: json['name'],
      arabicText: json['arabicText'],
      translationText: json['translationText'],
      ayahNumber: json['ayahNumber'],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  BookmarkEntity toEntity() {
    return BookmarkEntity(
      number: number,
      name: name,
      arabicText: arabicText,
      translationText: translationText,
      ayahNumber: ayahNumber,
      createdAt: createdAt,
    );
  }
}
