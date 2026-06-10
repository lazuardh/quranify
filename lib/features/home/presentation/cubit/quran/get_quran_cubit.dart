import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

part 'get_quran_state.dart';

class GetQuranCubit extends Cubit<GetQuranState> {
  final AllSongsRepository _allSongsRepository;

  GetQuranCubit(this._allSongsRepository) : super(GetQuranInitial());

  Future<void> getQuran({bool isLoading = true}) async {
    emit(GetQuranLoading(isLoading: isLoading));

    final response = await _allSongsRepository.getQuranApi();

    emit(
      response.fold(
        (failure) => GetQuranError(failure),
        (list) => GetQuranLoaded(listQuranEntity: list.data),
      ),
    );
  }
}
