import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _player = AudioPlayer();

  int? _currentSurah;
  int _currentAyah = 1;
  int _totalAyah = 0;

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  StreamSubscription? _playerStateSub;
  StreamSubscription? _positionSub;
  StreamSubscription? _durationSub;
  StreamSubscription? _indexSub;

  AudioPlayerCubit() : super(AudioPlayerInitial()) {
    _player.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;
      final playing = playerState.playing;

      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        emit(AudioPlayerLoading());
        return;
      }

      if (processingState == ProcessingState.completed) {
        emit(AudioPlayerInitial());
        return;
      }

      if (_currentSurah == null) return;

      if (playing) {
        emit(
          AudioPlayerPlaying(
            surahNumber: _currentSurah ?? 0,
            currentAyah: _currentAyah,
            totalAyah: _totalAyah,
            duration: _duration,
            position: _position,
          ),
        );
      } else {
        emit(
          AudioPlayerPaused(
            surahNumber: _currentSurah ?? 0,
            currentAyah: _currentAyah,
            totalAyah: _totalAyah,
            duration: _duration,
            position: _position,
          ),
        );
      }
    });

    _positionSub = _player.positionStream.listen((position) {
      _position = position;
      _emitProgress();
    });

    _durationSub = _player.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      _emitProgress();
    });

    _indexSub = _player.currentIndexStream.listen((index) {
      _currentAyah = (index ?? 0) + 1;
      _emitProgress();
    });
  }

  void _emitProgress() {
    if (_currentSurah == null) return;

    final currentState = state;

    if (currentState is AudioPlayerPlaying) {
      emit(
        AudioPlayerPlaying(
          surahNumber: _currentSurah!,
          currentAyah: _currentAyah,
          totalAyah: _totalAyah,
          position: _position,
          duration: _duration,
        ),
      );
    }

    if (currentState is AudioPlayerPaused) {
      emit(
        AudioPlayerPaused(
          surahNumber: _currentSurah!,
          currentAyah: _currentAyah,
          totalAyah: _totalAyah,
          position: _position,
          duration: _duration,
        ),
      );
    }
  }

  Future<void> play({
    required List<String> urls,
    required int surahNumber,
  }) async {
    try {
      emit(AudioPlayerLoading());

      _currentSurah = surahNumber;
      _currentAyah = 1;
      _totalAyah = urls.length;

      await _player.setAudioSources(
        urls.map((e) => AudioSource.uri(Uri.parse(e))).toList(),
        initialIndex: 0,
        initialPosition: Duration.zero,
      );

      await _player.play();

      emit(
        AudioPlayerPlaying(
          surahNumber: surahNumber,
          currentAyah: _currentAyah,
          totalAyah: _totalAyah,
          duration: _duration,
          position: _position,
        ),
      );
    } catch (e) {
      emit(AudioPlayerError(e.toString()));
    }
  }

  Future<void> pause() async {
    await _player.pause();

    if (_currentSurah != null) {
      emit(
        AudioPlayerPaused(
          surahNumber: _currentSurah!,
          currentAyah: _currentAyah,
          totalAyah: _totalAyah,
          duration: _duration,
          position: _position,
        ),
      );
    }
  }

  Future<void> resume() async {
    await _player.play();

    if (_currentSurah != null) {
      emit(
        AudioPlayerPlaying(
          surahNumber: _currentSurah!,
          currentAyah: _currentAyah,
          totalAyah: _totalAyah,
          duration: _duration,
          position: _position,
        ),
      );
    }
  }

  Future<void> stop() async {
    await _player.stop();

    _currentSurah = null;
    _currentAyah = 1;
    _totalAyah = 0;
    _position = Duration.zero;
    _duration = Duration.zero;

    emit(AudioPlayerInitial());
  }

  bool get isPlaying => _player.playing;

  int? get currentSurah => _currentSurah;

  @override
  Future<void> close() async {
    await _playerStateSub?.cancel();
    await _positionSub?.cancel();
    await _durationSub?.cancel();
    await _indexSub?.cancel();

    await _player.dispose();
    return super.close();
  }
}
