import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GetQuranCubit _cubit;

  @override
  void initState() {
    _cubit = getIt<GetQuranCubit>();

    context.read<LastReadCubit>().loadLastRead();
    context.read<BookmarkCubit>().load();
    _cubit.getQuran();
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
      child: BlocConsumer<GetQuranCubit, GetQuranState>(
        builder: (context, state) {
          return _HomeScreenWrapper(
            qurans: state is GetQuranLoaded ? state.filtered ?? [] : [],
            isLoading: state is GetQuranLoading && state.isLoading,
            isSearch: state is GetQuranLoaded ? state.isSearching : false,
          );
        },
        listener: (context, state) {
          if (state is GetQuranError) {
            print(state.failure.message);
            print(state.failure.error);
          }
        },
      ),
    );
  }
}

class _HomeScreenWrapper extends StatelessWidget {
  const _HomeScreenWrapper({
    required List<QuranEntity> qurans,
    required bool isLoading,
    bool isSearch = false,
  }) : _qurans = qurans,
       _isLoading = isLoading,
       _isSearch = isSearch;

  final List<QuranEntity> _qurans;
  final bool _isLoading;
  final bool _isSearch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextConstant.homeTitle,
          style: AppTextStyle.semiBold.copyWith(fontSize: 16),
        ),
      ),
      body: ColumnPadding(
        padding: const EdgeInsetsGeometry.all(10),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearch(
            onChanged: (value) =>
                context.read<GetQuranCubit>().searchQurans(value),
          ),

          const HomeTabBar(),

          BlocBuilder<HomeCubit, HomeCubitState>(
            builder: (context, state) {
              switch (state.selectedTab) {
                case HomeTab.surah:
                  return Expanded(
                    child: SurahContent(qurans: _qurans, isSearch: _isSearch),
                  );
                case HomeTab.juz:
                  return Expanded(child: const JuzContent());
                case HomeTab.bookmark:
                  return const BookmarkContent();
              }
            },
          ),
        ],
      ),
    );
  }
}

class SurahContent extends StatelessWidget {
  const SurahContent({super.key, required this.qurans, required this.isSearch});

  final List<QuranEntity> qurans;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSearch) ...[QuranSummaryCard(qurans: qurans), _titleContent()],

        Expanded(child: CardItemListQuran(listQuran: qurans)),
      ],
    );
  }

  Widget _titleContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
        'Surah List',
        style: AppTextStyle.bold.copyWith(fontSize: 18),
      ),
    );
  }
}

class JuzContent extends StatelessWidget {
  const JuzContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.n700,
              border: Border.all(color: AppColors.inkSoft),
              shape: BoxShape.circle,
            ),
            child: const CustomImageWrapper(
              image: AppIcons.mosque,
              isNetworkImage: false,
            ),
          ),
          const Gap(height: 10),
          Text('Coming Soon', style: AppTextStyle.bold.copyWith(fontSize: 18)),
          const Gap(height: 5),
          Text(
            'Were working on this feature. Stay tuned for upcoming updates.',
            style: AppTextStyle.bold.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BookmarkContent extends StatelessWidget {
  const BookmarkContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state is GetBookmarkLoaded) {
          return ItemCardSurah(
            numberInSurah: state.bookmark.ayahNumber,
            arabicText: state.bookmark.arabicText,
            translationText: state.bookmark.translationText,
          );
        }

        if (state is GetBookmarkEmpty) {
          return Expanded(child: _bookmarkEmpty());
        }

        return ItemCardSurah(arabicText: '', translationText: '');
      },
    );
  }

  Widget _bookmarkEmpty() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.n700,
              border: Border.all(color: AppColors.inkSoft),
              shape: BoxShape.circle,
            ),
            child: const CustomImageWrapper(
              image: AppIcons.mosque,
              isNetworkImage: false,
            ),
          ),
          const Gap(height: 10),
          Text(
            'No Bookmark Yet.',
            style: AppTextStyle.bold.copyWith(fontSize: 18),
          ),
          const Gap(height: 5),
          Text(
            'Your favorite Ayah and surah will appear \nhere for quick access.',
            style: AppTextStyle.bold.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
