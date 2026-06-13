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
  late final LastReadCubit _lastReadCubit;

  @override
  void initState() {
    _cubit = getIt<GetSurahCubit>();
    _cubit.getSurah(number: widget.params.number);

    _lastReadCubit = getIt<LastReadCubit>();
    _lastReadCubit.loadLastRead();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    _lastReadCubit.close();
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
        playQuran: () {},
      ),
      body: ListView.builder(
        itemCount: _detailSurah.ayahs.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemCardSurah(
            onTap: () {
              _savedCurrentData(
                context,
                ayahNumber: _detailSurah.ayahs[index].numberInSurah,
                numberSurah: _detailSurah.number,
                surahName: _detailSurah.name,
              );
            },
            arabicText: _detailSurah.ayahs[index].arabicText,
            numberInSurah: _detailSurah.ayahs[index].numberInSurah,
            surahNumber: _detailSurah.number ?? 0,
            translationText: _detailSurah.ayahs[index].translationText,
          );
        },
      ),
      bottomSheet: SelectedQori(),
      // bottomNavigationBar: PlayQuranCard(
      //   name: _detailSurah.name,
      //   qori: "Mishary Rashid Alafasy",
      //   progress: 0.55,
      //   currentDuration: "0:42",
      //   totalDuration: "1:24",
      // ),
    );
  }

  Future<void> _savedCurrentData(
    BuildContext context, {
    int? numberSurah,
    String? surahName,
    int? ayahNumber,
  }) async {
    context.confirmationDialog(
      message: 'Are you sure you want to bookmark this verse?',
      onPressed: () async {
        Navigator.pop(context); // tutup dialog dulu

        context.read<LastReadCubit>().saveLastRead(
          LastReadEntity(
            surahNumber: numberSurah ?? 0,
            surahName: surahName ?? '',
            ayahNumber: ayahNumber ?? 0,
          ),
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Last read saved $surahName ayah $numberSurah"),
            ),
          );
        }
      },
    );
  }
}

class SelectedQori extends StatelessWidget {
  const SelectedQori({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: theme.primary.withValues(alpha: .88),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Divider(
            indent: 160,
            endIndent: 160,
            thickness: 8,
            radius: BorderRadius.circular(10),
          ),
          Gap(height: 20),
          const CustomSearchWithoutSuffixIcon(),
          Gap(height: 10),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                maxRadius: 25,
                child: Icon(Icons.mic, size: 20),
              ),
              contentPadding: EdgeInsets.all(10),
              title: Text(
                'Mishary al-rashid',
                style: AppTextStyle.medium.copyWith(fontSize: 14),
              ),
              subtitle: Text(
                'Mishary al-rashid',
                style: AppTextStyle.medium.copyWith(fontSize: 12),
              ),
              trailing: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.3,
                ),
                child: Row(
                  children: [
                    Text(
                      'Now Playing',
                      style: AppTextStyle.medium.copyWith(
                        color: theme.secondary,
                        fontSize: 10,
                      ),
                    ),
                    Gap(width: 10),
                    Icon(Icons.play_arrow_rounded, color: theme.secondary),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
