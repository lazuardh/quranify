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
            listQuran: state is GetQuranLoaded
                ? state.listQuranEntity ?? []
                : [],
            isLoading: state is GetQuranLoading && state.isLoading,
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
    required List<QuranEntity> listQuran,
    required bool isLoading,
  }) : _listQuran = listQuran,
       _isLoading = isLoading;

  final List<QuranEntity> _listQuran;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextConstant.homeTitle,
          style: AppTextStyle.semiBold.copyWith(fontSize: 16),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearch(),
          const CustomSchrollWrapper(),
          QuranSummaryCard(qurans: _listQuran),
          _titleContent(),
          Expanded(child: CardItemListQuran(listQuran: _listQuran)),
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
