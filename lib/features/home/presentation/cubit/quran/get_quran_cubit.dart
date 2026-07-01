import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

part 'get_quran_state.dart';

class GetQuranCubit extends Cubit<GetQuranState> {
  final AllSongsRepository _allSongsRepository;

  GetQuranCubit(this._allSongsRepository) : super(GetQuranInitial());

  List<QuranEntity> _qurans = [];

  Future<void> getQuran({bool isLoading = true}) async {
    emit(GetQuranLoading(isLoading: isLoading));

    final response = await _allSongsRepository.getQuranApi();

    emit(
      response.fold((failure) => GetQuranError(failure), (list) {
        _qurans = list.data ?? [];
        return GetQuranLoaded(qurans: _qurans, filtered: _qurans);
      }),
    );
  }

  void searchQurans(String keyword) {
    if (state is! GetQuranLoaded) return;

    final query = keyword.trim().toLowerCase();

    if (query.isEmpty) {
      emit(GetQuranLoaded(qurans: _qurans, filtered: _qurans));
      return;
    }

    final filtered = _qurans
        .where((quran) => quran.name.toLowerCase().contains(query))
        .toList();

    emit(GetQuranLoaded(qurans: _qurans, filtered: filtered, keyword: query));
  }

  List<String> get surahNames => _qurans.map((e) => e.name).toList();
}
