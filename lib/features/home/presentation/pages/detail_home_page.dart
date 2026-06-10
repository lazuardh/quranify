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

  @override
  void initState() {
    _cubit = getIt<GetSurahCubit>();
    _cubit.getSurah(number: widget.params.number);
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
    final theme = Theme.of(context).colorScheme;

    if (_detailSurah == null) {
      return Text('No Data found');
    }

    return Scaffold(
      appBar: CustomAppBarSurah(
        name: _detailSurah.name,
        numberOfAyah: _detailSurah.numberOfAyat,
        relevationType: _detailSurah.relevationType,
      ),
      body: ListView.builder(
        itemCount: _detailSurah.ayahs.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Card(
              child: ColumnPadding(
                padding: EdgeInsetsGeometry.all(20),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.tertiary),
                        ),
                        child: Text('${_detailSurah.ayahs[index].number}'),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.bookmark, size: 18),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: Text(
                      _detailSurah.ayahs[index].arabicText,
                      style: AppTextStyle.regular.copyWith(fontSize: 20),
                    ),
                  ),
                  Divider(),
                  Text(
                    _detailSurah.ayahs[index].translationText,
                    style: AppTextStyle.regular.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: PlayQuranCard(
        name: _detailSurah.name,
        qori: "Mishary Rashid Alafasy",
        progress: 0.55,
        currentDuration: "0:42",
        totalDuration: "1:24",
      ),
    );
  }
}
