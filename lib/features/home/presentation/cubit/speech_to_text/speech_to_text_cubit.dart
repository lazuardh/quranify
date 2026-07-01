import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'speech_to_text_state.dart';

class SpeechToTextCubit extends Cubit<SpeechToTextState> {
  SpeechToTextCubit() : super(const SpeechToTextState());

  final SpeechToText _speechToText = SpeechToText();

  Future<void> initialize() async {
    final available = await _speechToText.initialize(
      onStatus: (status) {
        debugPrint('STATUS => $status');
        emit(state.copyWith(isListening: status == 'listening'));
      },
      onError: (error) {
        debugPrint('ERROR => $error');
        emit(state.copyWith(isListening: false));
      },

      debugLogging: true,
    );

    emit(state.copyWith(isInitialized: available));
  }

  Future<void> startListening() async {
    await _speechToText.listen(
      listenFor: Duration(seconds: 30),
      localeId: 'id_ID',
      onResult: _onSpeechResult,
    );

    final locales = await _speechToText.locales();

    for (final locale in locales) {
      debugPrint('${locale.localeId} ${locale.name}');
    }
  }

  Future<void> stopListening() async {
    await _speechToText.stop();

    emit(state.copyWith(isListening: false));
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    emit(state.copyWith(recognizedWords: result.recognizedWords));
  }

  @override
  Future<void> close() {
    _speechToText.stop();
    return super.close();
  }
}
