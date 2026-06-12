import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

class QuranSummaryCard extends StatelessWidget {
  const QuranSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BlocSummery(),
          _KhatamProgressCard(summary: "KHATAM \nGOALS", progress: 42),
        ],
      ),
    );
  }
}

class _BlocSummery extends StatelessWidget {
  const _BlocSummery();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastReadCubit, LastReadState>(
      builder: (context, state) {
        if (state is LastReadLoading) {
          return CircularProgressIndicator();
        }

        if (state is LastReadEmpty) {
          return const _cardSummary(isLastRead: true);
        }

        if (state is LastReadLoaded) {
          return _cardSummary(
            surah: state.lastRead.surahName,
            ayah: state.lastRead.ayahNumber,
          );
        }

        return SizedBox();
      },
    );
  }
}

// ignore: camel_case_types
class _cardSummary extends StatelessWidget {
  const _cardSummary({String? surah, int? ayah, bool isLastRead = false})
    : _surah = surah,
      _ayah = ayah,
      _isLastRead = isLastRead;

  final String? _surah;
  final int? _ayah;
  final bool _isLastRead;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.sizeOf(context).width * 0.45,
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
                    _isLastRead == true ? "No \nHistory" : _surah ?? '',
                    style: AppTextStyle.semiBold.copyWith(
                      fontSize: 28,
                      color: theme.tertiary,
                    ),
                  ),
                  Text(
                    _isLastRead == true ? "Start Reading" : "Ayah $_ayah",
                    style: AppTextStyle.regular.copyWith(
                      fontSize: _isLastRead == true ? 16 : 20,
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
  const _KhatamProgressCard({required String summary, required int progress})
    : _summary = summary,
      _progress = progress;

  final String _summary;
  final int _progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.sizeOf(context).width * 0.45,
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
                  SizedBox(height: 5),
                  LinearProgressIndicator(value: 42 / 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
