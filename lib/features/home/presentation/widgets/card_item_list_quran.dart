import 'package:flutter/material.dart';
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
      prototypeItem: _item(
        name: 'Al-fatihah',
        relevationType: 'meccah',
        numberOfAyah: 7,
      ),

      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: Card(
            child: _item(
              name: _listQuran[index].name,
              relevationType: _listQuran[index].relevationType,
              numberOfAyah: _listQuran[index].numberOfAyat,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailHomePage(
                    params: DetailHomeScreenParams(
                      number: _listQuran[index].number,
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

// ignore: must_be_immutable, camel_case_types
class _item extends StatelessWidget {
  const _item({
    required String name,
    required String relevationType,
    int? numberOfAyah,
    void Function()? onTap,
  }) : _name = name,
       _relevationType = relevationType,
       _numberOfAyah = numberOfAyah,
       _onTap = onTap;

  final String _name;
  final String _relevationType;
  final int? _numberOfAyah;
  final void Function()? _onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(Icons.ac_unit_sharp, size: 40, color: theme.tertiary),
      contentPadding: EdgeInsets.all(5),
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
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: theme.tertiary),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              _relevationType,
              style: AppTextStyle.regular.copyWith(
                fontSize: 10,
                color: theme.onSecondary,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$_numberOfAyah Ayah',
            style: AppTextStyle.regular.copyWith(
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
