class AudioSurahEntity {
  final int number;
  final List<AudioAyahEntity> ayahs;

  AudioSurahEntity({required this.number, required this.ayahs});
}

class AudioAyahEntity {
  final int number;
  final int numberInSurah;
  final String audio;
  final List<String> audioSecondary;

  AudioAyahEntity({
    required this.number,
    required this.numberInSurah,
    required this.audio,
    required this.audioSecondary,
  });
}
