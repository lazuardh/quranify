import 'package:quranify/lib.dart';

class ArtistModel {
  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;

  ArtistModel({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      identifier: json['identifier'],
      language: json['language'],
      name: json['name'],
      englishName: json['englishName'],
      format: json['format'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'language': language,
      'name': name,
      'englishName': englishName,
      'format': format,
      'type': type,
    };
  }

  ArtistEntity toEntity() {
    return ArtistEntity(
      identifier: identifier,
      language: language,
      name: name,
      englishName: englishName,
      format: format,
      type: type,
    );
  }
}
