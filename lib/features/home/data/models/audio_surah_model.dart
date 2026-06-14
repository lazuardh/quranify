import 'package:equatable/equatable.dart';
import 'package:quranify/lib.dart';

class AudioSurahModel extends Equatable {
  final int number;
  final List<AudioAyahModel> ayahs;

  const AudioSurahModel({required this.number, required this.ayahs});

  factory AudioSurahModel.fromJson(Map<String, dynamic> json) {
    return AudioSurahModel(
      number: json['number'],
      ayahs: (json['ayahs'] as List)
          .map((e) => AudioAyahModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'number': number, 'ayahs': ayahs};
  }

  AudioSurahEntity toEntity() {
    return AudioSurahEntity(
      number: number,
      ayahs: ayahs.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [number, ayahs];
}

class AudioAyahModel extends Equatable {
  final int number;
  final int numberInSurah;
  final String audio;
  final List<String> audioSecondary;

  const AudioAyahModel({
    required this.number,
    required this.numberInSurah,
    required this.audio,
    required this.audioSecondary,
  });

  factory AudioAyahModel.fromJson(Map<String, dynamic> json) {
    return AudioAyahModel(
      number: json['number'],
      numberInSurah: json['numberInSurah'],
      audio: json['audio'],
      audioSecondary: List<String>.from(json['audioSecondary'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah,
      'audio': audio,
      'audioSecondary': audioSecondary,
    };
  }

  AudioAyahEntity toEntity() {
    return AudioAyahEntity(
      number: number,
      numberInSurah: numberInSurah,
      audio: audio,
      audioSecondary: audioSecondary,
    );
  }

  @override
  List<Object?> get props => [number, numberInSurah, audio, audioSecondary];
}
