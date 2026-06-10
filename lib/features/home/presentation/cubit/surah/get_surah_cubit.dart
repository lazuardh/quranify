import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

part 'get_surah_state.dart';

class GetSurahCubit extends Cubit<GetSurahState> {
  final AllSongsRepository _allSongsRepository;
  GetSurahCubit(this._allSongsRepository) : super(GetSurahInitial());

  Future<void> getSurah({bool isLoading = true, int? number}) async {
    emit(GetSurahLoading(isLoading: isLoading));

    final response = await _allSongsRepository.getSurahApi(number);

    emit(
      response.fold(
        (failure) => GetSurahError(failure),
        (data) => GetSurahLoaded(surahEntity: data.data),
      ),
    );
  }
}
