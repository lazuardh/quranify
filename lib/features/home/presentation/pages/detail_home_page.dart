import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

class DetailHomePage extends StatefulWidget {
  final DetailHomeScreenParams params;
  const DetailHomePage({super.key, required this.params});

  @override
  State<DetailHomePage> createState() => _DetailHomePageState();
}

class _DetailHomePageState extends State<DetailHomePage> {
  late final GetSurahCubit _cubit;

  // late final GetDataCubit _getDataCubit;

  @override
  void initState() {
    _cubit = getIt<GetSurahCubit>();
    _cubit.getSurah(number: widget.params.number);

    context.read<GetDataCubit>()
      ..setNumberSurah(numberSurah: widget.params.number)
      ..load();

    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<GetSurahCubit, GetSurahState>(
        builder: (context, state) {
          if (state is GetSurahLoaded) {
            return _DetailHomePageWrapper(detailSurah: state.surahEntity);
          }

          return SizedBox();
        },
        listener: (context, state) {
          if (state is GetSurahError) {
            print(state.failure.message);
            print(state.failure.error);
          }
        },
      ),
    );
  }
}

class _DetailHomePageWrapper extends StatelessWidget {
  const _DetailHomePageWrapper({SurahEntity? detailSurah})
    : _detailSurah = detailSurah;

  final SurahEntity? _detailSurah;

  @override
  Widget build(BuildContext context) {
    if (_detailSurah == null) {
      return ItemCardSurah.empty();
    }

    return Scaffold(
      appBar: CustomAppBarSurah(
        name: _detailSurah.name,
        numberOfAyah: _detailSurah.numberOfAyat,
        relevationType: _detailSurah.relevationType,
      ),
      body: ListView.builder(
        itemCount: _detailSurah.ayahs.length + 1,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return PlayQuran(params: PlayQuranParams(name: _detailSurah.name));
          }

          final ayah = _detailSurah.ayahs[index - 1];

          return Column(
            children: [
              ItemCardSurah(
                onTap: () {
                  _savedCurrentData(
                    context,
                    ayahNumber: ayah.numberInSurah,
                    numberSurah: _detailSurah.number,
                    surahName: _detailSurah.name,
                    arabicText: ayah.arabicText,
                    translationText: ayah.translationText,
                  );
                },
                arabicText: ayah.arabicText,
                numberInSurah: ayah.numberInSurah,
                surahNumber: _detailSurah.number!,
                translationText: ayah.translationText,
              ),
            ],
          );
        },
      ),
      // bottomSheet: SelectedArtists(numberSurah: _detailSurah.number!),
    );
  }

  Future<void> _savedCurrentData(
    BuildContext context, {
    int? numberSurah,
    String? surahName,
    int? ayahNumber,
    String? arabicText,
    String? translationText,
  }) async {
    final lastReadState = context.read<LastReadCubit>().state;

    String message = 'Set QS. $surahName verse $ayahNumber as your last read?';

    if (lastReadState is LastReadLoaded) {
      final current = lastReadState.lastRead;

      message =
          'Last read will be changed from '
          'QS. ${current.surahName} verse ${current.ayahNumber} '
          'to QS. $surahName verse $ayahNumber. Continue?';
    }

    context.confirmationDialog(
      message: message,
      onPressed: () async {
        Navigator.pop(context); // tutup dialog dulu

        context.read<LastReadCubit>().saveLastRead(
          LastReadEntity(
            surahNumber: numberSurah ?? 0,
            surahName: surahName ?? '',
            ayahNumber: ayahNumber ?? 0,
          ),
        );

        context.read<BookmarkCubit>().saveBookmark(
          BookmarkEntity(
            number: numberSurah ?? 0,
            name: surahName ?? '',
            arabicText: arabicText ?? '',
            translationText: translationText ?? '',
            ayahNumber: ayahNumber ?? 0,
            createdAt: DateTime.now(),
          ),
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Saved $surahName ayah $ayahNumber")),
          );
        }
      },
    );
  }
}
