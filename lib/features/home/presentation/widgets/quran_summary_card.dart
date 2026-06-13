import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

class QuranSummaryCard extends StatelessWidget {
  const QuranSummaryCard({super.key, required this.qurans});

  final List<QuranEntity> qurans;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.3,
      ),
      child: BlocBuilder<LastReadCubit, LastReadState>(
        builder: (context, state) {
          if (state is LastReadLoading) {
            return CircularProgressIndicator();
          }

          if (state is LastReadEmpty) {
            return const _SummeryWrapper.empty();
          }

          if (state is LastReadLoaded) {
            return _buildLoaded(state);
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoaded(LastReadLoaded state) {
    final result = KhatamCalculator.calculate(
      surahs: qurans,
      currentSurah: state.lastRead.surahNumber,
      currentAyah: state.lastRead.ayahNumber,
    );

    return _SummeryWrapper(
      currentAyah: state.lastRead.ayahNumber,
      currentSurah: state.lastRead.surahName,
      progress: result.percentage.round(),
    );
  }
}

class _SummeryWrapper extends StatelessWidget {
  const _SummeryWrapper.empty()
    : _currentAyah = null,
      _currentSurah = null,
      _progress = 0,
      isEmpty = true;

  const _SummeryWrapper({
    String? currentSurah,
    int? currentAyah,
    int progress = 0,
  }) : _currentAyah = currentAyah,
       _currentSurah = currentSurah,
       _progress = progress,
       isEmpty = false;

  final String? _currentSurah;
  final int? _currentAyah;
  final int _progress;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _LastReadCard(
            surah: _currentSurah,
            ayah: _currentAyah,
            isEmpty: isEmpty,
          ),
        ),
        Gap(width: 12),
        Expanded(child: _KhatamProgressCard(progress: _progress)),
      ],
    );
  }
}

// ignore: camel_case_types
class _LastReadCard extends StatelessWidget {
  const _LastReadCard({String? surah, int? ayah, bool isEmpty = false})
    : _surah = surah,
      _ayah = ayah,
      _isEmpty = isEmpty;

  final String? _surah;
  final int? _ayah;
  final bool _isEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        // width: MediaQuery.sizeOf(context).width * 0.45,
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: Stack(
          children: [
            Positioned(
              top: -8,
              right: 5,
              child: Icon(Icons.auto_stories, size: 60, color: theme.primary),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LAST READ',
                    style: AppTextStyle.regular.copyWith(fontSize: 18),
                  ),
                  Text(
                    _isEmpty ? "No \nHistory" : _surah ?? '',
                    style: AppTextStyle.semiBold.copyWith(
                      fontSize: 28,
                      color: theme.tertiary,
                    ),
                  ),
                  Text(
                    _isEmpty ? "Start Reading" : "Ayah $_ayah",
                    style: AppTextStyle.regular.copyWith(
                      fontSize: _isEmpty ? 16 : 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KhatamProgressCard extends StatelessWidget {
  const _KhatamProgressCard({
    String summary = "KHATAM \nGOALS",
    required int progress,
  }) : _summary = summary,
       _progress = progress;

  final String _summary;
  final int _progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        // width: MediaQuery.sizeOf(context).width * 0.45,
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: Stack(
          children: [
            Positioned(
              top: -8,
              right: 5,
              child: Icon(
                Icons.track_changes_outlined,
                size: 60,
                color: theme.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _summary,
                    style: AppTextStyle.regular.copyWith(fontSize: 18),
                  ),
                  Text(
                    "$_progress %",
                    style: AppTextStyle.semiBold.copyWith(
                      fontSize: 28,
                      color: theme.secondary,
                    ),
                  ),
                  Text(
                    "Complete",
                    style: AppTextStyle.semiBold.copyWith(
                      fontSize: 20,
                      color: theme.secondary,
                    ),
                  ),
                  const Gap(height: 5),
                  LinearProgressIndicator(value: _progress / 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
