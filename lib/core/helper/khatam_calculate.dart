import '../../lib.dart';

class KhatamCalculator {
  static ({double percentage, int readAyah, int totalAyah}) calculate({
    required List<QuranEntity> surahs,
    required int currentSurah,
    required int currentAyah,
  }) {
    final totalAyah = surahs.fold<int>(
      0,
      (sum, item) => sum + (item.numberOfAyat ?? 0),
    );

    int readAyah = 0;

    for (final surah in surahs) {
      if ((surah.number ?? 0) < currentSurah) {
        readAyah += surah.numberOfAyat ?? 0;
      }
    }

    readAyah += currentAyah;

    final double percentage = totalAyah == 0
        ? 0.0
        : (readAyah / totalAyah) * 100;

    return (totalAyah: totalAyah, readAyah: readAyah, percentage: percentage);
  }
}
