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
        padding: EdgeInsetsGeometry.all(10),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearch(
            onChanged: (value) =>
                context.read<GetQuranCubit>().searchQurans(value),
          ),
          _isSearch ? const SizedBox.shrink() : const CustomSchrollWrapper(),
          _isSearch
              ? const SizedBox.shrink()
              : QuranSummaryCard(qurans: _qurans),
          _isSearch ? const SizedBox.shrink() : _titleContent(),
          _isSearch ? const Gap(height: 10) : const SizedBox.shrink(),
          Expanded(child: CardItemListQuran(listQuran: _qurans)),
        ],
      ),
    );
  }

  Widget _titleContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        'Surah List',
        style: AppTextStyle.bold.copyWith(fontSize: 18),
      ),
    );
  }
}
