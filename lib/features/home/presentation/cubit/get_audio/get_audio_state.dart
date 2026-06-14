part of 'get_audio_cubit.dart';

abstract class GetAudioState extends Equatable {
  const GetAudioState();

  @override
  List<Object?> get props => [];
}

class GetAudioInitial extends GetAudioState {}

class GetAudioLoading extends GetAudioState {}

class GetAudioLoaded extends GetAudioState {
  final AudioSurahEntity? audios;
  const GetAudioLoaded({required this.audios});

  @override
  List<Object?> get props => [audios];
}

class GetAudioError extends GetAudioState {
  final String message;
  const GetAudioError(this.message);

  @override
  List<Object?> get props => [message];
}
