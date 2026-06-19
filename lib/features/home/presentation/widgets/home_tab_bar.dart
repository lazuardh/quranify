import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/features/features.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          constraints: BoxConstraints(minHeight: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ItemTab(
                title: 'Surah',
                selected: state.selectedTab == HomeTab.surah,
                onTap: () {
                  context.read<HomeCubit>().changedTab(HomeTab.surah);
                },
              ),

              ItemTab(
                title: 'Juz',
                selected: state.selectedTab == HomeTab.juz,
                onTap: () {
                  context.read<HomeCubit>().changedTab(HomeTab.juz);
                },
              ),

              ItemTab(
                title: 'Bookmark',
                selected: state.selectedTab == HomeTab.bookmark,
                onTap: () {
                  context.read<HomeCubit>().changedTab(HomeTab.bookmark);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ItemTab extends StatelessWidget {
  const ItemTab({
    super.key,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) : _title = title,
       _selected = selected,
       _onTap = onTap;

  final String _title;
  final bool _selected;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: _onTap,
      child: _selected
          ? Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: MediaQuery.sizeOf(context).width * 0.05,
                ),
                child: Text(
                  _title,
                  style: AppTextStyle.black.copyWith(fontSize: 14),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
              ),
              child: Text(
                _title,
                style: AppTextStyle.black.copyWith(fontSize: 14),
              ),
            ),
    );
  }
}
