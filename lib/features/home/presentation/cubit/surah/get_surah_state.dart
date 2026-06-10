part of 'get_surah_cubit.dart';

sealed class GetSurahState extends Equatable {
  const GetSurahState();

  @override
  List<Object> get props => [];
}

final class GetSurahInitial extends GetSurahState {}

class GetSurahLoading extends GetSurahState {
  final bool isLoading;
  const GetSurahLoading({required this.isLoading});
}

class GetSurahLoaded extends GetSurahState {
  final SurahEntity? surahEntity;
  const GetSurahLoaded({required this.surahEntity});
}

class GetSurahError extends GetSurahState {
  final Failure failure;
  const GetSurahError(this.failure);
}
