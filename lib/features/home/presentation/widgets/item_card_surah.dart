import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../lib.dart';

class ItemCardSurah extends StatelessWidget {
  const ItemCardSurah.empty({super.key})
    : _onTap = null,
      _numberInSurah = 0,
      _surahNumber = 0,
      _arabicText = 'NO SURAH',
      _translationText = 'NO TRANSLATION';

  const ItemCardSurah({
    super.key,
    void Function()? onTap,
    int numberInSurah = 0,
    int surahNumber = 0,
    String arabicText = '',
    String translationText = '',
  }) : _onTap = onTap,
       _numberInSurah = numberInSurah,
       _surahNumber = surahNumber,
       _arabicText = arabicText,
       _translationText = translationText;

  final void Function()? _onTap;
  final int _numberInSurah;
  final int _surahNumber;
  final String _arabicText;
  final String _translationText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: InkWell(
        onTap: _onTap,
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
                    child: Text(_numberInSurah.toString()),
                  ),

                  BlocSelector<LastReadCubit, LastReadState, LastReadEntity?>(
                    selector: (state) {
                      if (state is LastReadLoaded) {
                        return state.lastRead;
                      }

                      return null;
                    },
                    builder: (context, lastRead) {
                      final isBookmarked =
                          lastRead?.surahNumber == _surahNumber &&
                          lastRead?.ayahNumber == _numberInSurah;

                      return Icon(
                        Icons.bookmark,
                        size: 18,
                        color: isBookmarked ? theme.tertiary : theme.onPrimary,
                      );
                    },
                  ),
                ],
              ),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: Text(
                  _arabicText,
                  style: AppTextStyle.regular.copyWith(fontSize: 20),
                ),
              ),
              Divider(),
              Text(
                _translationText,
                style: AppTextStyle.regular.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
