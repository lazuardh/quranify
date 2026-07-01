import 'dart:math';

class VoiceSearchHelper {
  static String normalize(String text) {
    return text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '').trim();
  }

  static String? findBestMatch({
    required String query,
    required List<String> candidates,
    double minSimilarity = 0.7,
  }) {
    if (query.trim().isEmpty) return null;

    final normalizedQuery = normalize(query);

    String? bestMatch;
    double bestSimilarity = 0;

    for (final candidate in candidates) {
      final normalizedCandidate = normalize(candidate);

      final distance = _levenshtein(normalizedQuery, normalizedCandidate);

      final similarity =
          1 -
          (distance / max(normalizedQuery.length, normalizedCandidate.length));

      if (similarity > bestSimilarity) {
        bestSimilarity = similarity;
        bestMatch = candidate;
      }
    }

    if (bestSimilarity < minSimilarity) {
      return null;
    }

    return bestMatch;
  }

  static int _levenshtein(String s, String t) {
    final rows = s.length + 1;
    final cols = t.length + 1;

    final matrix = List.generate(rows, (_) => List.filled(cols, 0));

    for (int i = 0; i < rows; i++) {
      matrix[i][0] = i;
    }

    for (int j = 0; j < cols; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i < rows; i++) {
      for (int j = 1; j < cols; j++) {
        final cost = s[i - 1] == t[j - 1] ? 0 : 1;

        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce(min);
      }
    }

    return matrix[rows - 1][cols - 1];
  }
}
