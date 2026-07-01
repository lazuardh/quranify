part of 'speech_to_text_cubit.dart';

class SpeechToTextState extends Equatable {
  final bool isInitialized;
  final bool isListening;
  final String recognizedWords;

  const SpeechToTextState({
    this.isInitialized = false,
    this.isListening = false,
    this.recognizedWords = '',
  });

  SpeechToTextState copyWith({
    bool? isInitialized,
    bool? isListening,
    String? recognizedWords,
  }) {
    return SpeechToTextState(
      isInitialized: isInitialized ?? this.isInitialized,
      isListening: isListening ?? this.isListening,
      recognizedWords: recognizedWords ?? this.recognizedWords,
    );
  }

  @override
  List<Object> get props => [isInitialized, isListening, recognizedWords];
}
