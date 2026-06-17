import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/features/home/presentation/pages/detail_home_page.dart';

import '../../../../lib.dart';

class CardItemListQuran extends StatelessWidget {
  const CardItemListQuran({super.key, required List<QuranEntity> listQuran})
    : _listQuran = listQuran;

  final List<QuranEntity> _listQuran;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listQuran.length,
      padding: EdgeInsets.symmetric(horizontal: 10),
      physics: const ClampingScrollPhysics(),
      prototypeItem: _ItemQuran(
        number: 1,
        name: 'Al-fatihah',
        relevationType: 'meccah',
        numberOfAyah: 7,
      ),

      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: Card(
            child: _ItemQuran(
              number: _listQuran[index].number ?? 0,
              name: _listQuran[index].name,
              relevationType: _listQuran[index].relevationType,
              numberOfAyah: _listQuran[index].numberOfAyat,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: context.read<LastReadCubit>(),
                    child: DetailHomePage(
                      params: DetailHomeScreenParams(
                        number: _listQuran[index].number,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ItemQuran extends StatelessWidget {
  const _ItemQuran({
    required String name,
    required String relevationType,
    int? numberOfAyah,
    void Function()? onTap,
    required int number,
  }) : _name = name,
       _relevationType = relevationType,
       _numberOfAyah = numberOfAyah,
       _onTap = onTap,
       _number = number;

  final String _name;
  final String _relevationType;
  final int? _numberOfAyah;
  final void Function()? _onTap;
  final int _number;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ListTile(
      leading: AyahMarker(number: _number),
      contentPadding: EdgeInsets.only(
        left: 20,
        bottom: MediaQuery.paddingOf(context).bottom - 13,
      ),
      title: Text(
        _name,
        style: AppTextStyle.bold.copyWith(
          fontSize: 16,
          color: theme.onSecondary,
        ),
      ),
      subtitle: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.tertiaryLight.withOpacity(0.2),
              border: Border.all(color: theme.tertiary, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                _relevationType,
                style: AppTextStyle.regular.copyWith(
                  fontSize: 10,
                  color: theme.onSecondary,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$_numberOfAyah Ayah',
            style: AppTextStyle.medium.copyWith(
              fontSize: 12,
              color: theme.onSecondary,
            ),
          ),
        ],
      ),
      onTap: _onTap,
    );
  }
}
