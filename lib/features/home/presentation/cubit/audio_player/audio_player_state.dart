part of 'audio_player_cubit.dart';

sealed class AudioPlayerState extends Equatable {
  final int? surahNumber;
  final int currentAyah;
  final int totalAyah;
  final Duration position;
  final Duration duration;

  const AudioPlayerState({
    this.surahNumber,
    this.currentAyah = 0,
    this.totalAyah = 0,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  double get progress {
    if (totalAyah == 0) return 0;

    final ayahProgress = duration.inMilliseconds == 0
        ? 0
        : position.inMilliseconds / duration.inMilliseconds;

    return ((currentAyah - 1) + ayahProgress) / totalAyah;
  }

  @override
  List<Object?> get props => [
    surahNumber,
    currentAyah,
    totalAyah,
    position,
    duration,
  ];
}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerLoading extends AudioPlayerState {}

class AudioPlayerPlaying extends AudioPlayerState {
  const AudioPlayerPlaying({
    required super.surahNumber,
    required super.currentAyah,
    required super.totalAyah,
    required super.position,
    required super.duration,
  });
}

class AudioPlayerPaused extends AudioPlayerState {
  const AudioPlayerPaused({
    required super.surahNumber,
    required super.currentAyah,
    required super.totalAyah,
    required super.position,
    required super.duration,
  });
}

class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
