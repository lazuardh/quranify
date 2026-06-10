import '../../../../lib.dart';

class LastReadModel {
  final int surahNumber;
  final String surahName;
  final int ayahNumber;

  const LastReadModel({
    required this.surahNumber,
    required this.surahName,
    required this.ayahNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'surahNumber': surahNumber,
      'surahName': surahName,
      'ayahNumber': ayahNumber,
    };
  }

  factory LastReadModel.fromJson(Map<String, dynamic> json) {
    return LastReadModel(
      surahNumber: json['surahNumber'],
      surahName: json['surahName'],
      ayahNumber: json['ayahNumber'],
    );
  }

  LastReadEntity toEntity() {
    return LastReadEntity(
      surahNumber: surahNumber,
      surahName: surahName,
      ayahNumber: ayahNumber,
    );
  }
}
