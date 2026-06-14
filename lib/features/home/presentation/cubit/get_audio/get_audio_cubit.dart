import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

part 'get_audio_state.dart';

class GetAudioCubit extends Cubit<GetAudioState> {
  final AllSongsRepository _repository;
  GetAudioCubit(this._repository) : super(GetAudioInitial());

  Future<void> getAudio({required int number, required String artist}) async {
    emit(GetAudioLoading());

    final response = await _repository.getAudioSurahApi(
      number: number,
      artist: artist,
    );

    emit(
      response.fold(
        (failure) => GetAudioError(failure.message),
        (response) => GetAudioLoaded(audios: response.data),
      ),
    );
  }
}
