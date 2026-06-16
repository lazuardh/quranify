import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

class PlayQuran extends StatefulWidget {
  const PlayQuran({super.key, required PlayQuranParams params})
    : _params = params;

  final PlayQuranParams _params;

  @override
  State<PlayQuran> createState() => _PlayQuranState();
}

class _PlayQuranState extends State<PlayQuran> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAudioCubit, GetAudioState>(
      listener: (context, state) {
        if (state is GetAudioLoaded) {
          final urls = state.audios?.ayahs
              .map((e) => e.audio)
              .whereType<String>()
              .toList();

          if (urls == null || urls.isEmpty) {
            return context.attentionDialog(
              message: 'Audio Tidak Tersedia',
              onPressed: () => Navigator.pop(context),
            );
          }

          final surah = context.read<GetDataCubit>().state.numberSurah;
          final artist = context.read<GetDataCubit>().state.identifier;

          context.read<AudioPlayerCubit>().play(
            urls: urls,
            surahNumber: surah,
            artistIdentifier: artist,
          );
        }
      },
      child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
        builder: (context, state) {
          return PlayQuranCard(
            name: widget._params.name,
            qori: context.select<GetDataCubit, String>(
              (cubit) => cubit.state.name,
            ),
            ayat: state is AudioPlayerPlaying || state is AudioPlayerPaused
                ? '${state.currentAyah}/${state.totalAyah}'
                : '',
            progress: state.progress,
            currentDuration: state.position.format(),
            totalDuration: state.duration.format(),
            playButton: () {
              final audioCubit = context.read<AudioPlayerCubit>();
              final playerState = audioCubit.state;

              final dataState = context.read<GetDataCubit>().state;

              final currentSurah = dataState.numberSurah;
              final currentArtist = dataState.identifier;

              final sameSurah = audioCubit.currentSurah == currentSurah;

              final sameArtist = audioCubit.currentArtist == currentArtist;

              /// pause
              if (playerState is AudioPlayerPlaying &&
                  sameSurah &&
                  sameArtist) {
                audioCubit.pause();
                return;
              }

              /// resume
              if (playerState is AudioPlayerPaused && sameSurah && sameArtist) {
                audioCubit.resume();
                return;
              }

              /// load audio baru
              context.read<GetAudioCubit>().getAudio(
                number: currentSurah,
                artist: currentArtist,
              );

              print('artist ==> $currentArtist');
            },
          );
        },
      ),
    );
  }
}

class PlayQuranCard extends StatelessWidget {
  const PlayQuranCard({
    super.key,
    required this.name,
    required this.qori,
    required this.progress,
    required this.currentDuration,
    required this.totalDuration,
    void Function()? playButton,
    required String ayat,
  }) : _playButton = playButton,
       _ayat = ayat;

  final String name;
  final String qori;
  final double progress;
  final String currentDuration;
  final String totalDuration;
  final void Function()? _playButton;
  final String _ayat;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: MediaQuery.viewPaddingOf(context).bottom + 2,
      ),
      height: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.surface.withValues(alpha: .8),
      ),
      child: Column(
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.primary.withValues(alpha: .15),
                ),
                child: const Icon(Icons.library_music, size: 20),
              ),

              const Gap(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyle.bold.copyWith(fontSize: 16)),
                    const Gap(height: 4),
                    Text(
                      qori.toUpperCase(),
                      style: AppTextStyle.regular.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                child: const Icon(Icons.menu_book_rounded, size: 18),
              ),

              Text(_ayat, style: AppTextStyle.medium.copyWith(fontSize: 12)),
            ],
          ),

          const Gap(height: 16),

          /// PROGRESS
          LinearProgressIndicator(value: progress),

          const Gap(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentDuration,
                style: AppTextStyle.regular.copyWith(fontSize: 12),
              ),
              Text(
                totalDuration,
                style: AppTextStyle.regular.copyWith(fontSize: 12),
              ),
            ],
          ),

          const Gap(height: 10),

          /// PLAYER CONTROL
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: const Icon(Icons.fast_rewind),
              ),

              const Gap(width: 8),

              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.secondary,
                ),
                child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                  builder: (context, state) {
                    return IconButton(
                      iconSize: 22,
                      color: Colors.white,
                      onPressed: _playButton,
                      icon: Icon(
                        state is AudioPlayerPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                    );
                  },
                ),
              ),

              const Gap(width: 8),

              IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: const Icon(Icons.fast_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
