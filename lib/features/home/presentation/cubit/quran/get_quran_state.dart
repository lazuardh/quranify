part of 'get_quran_cubit.dart';

abstract class GetQuranState extends Equatable {
  const GetQuranState();

  @override
  List<Object> get props => [];
}

class GetQuranInitial extends GetQuranState {}

class GetQuranLoading extends GetQuranState {
  final bool isLoading;
  const GetQuranLoading({required this.isLoading});
}

class GetQuranLoaded extends GetQuranState {
  final List<QuranEntity>? listQuranEntity;
  const GetQuranLoaded({required this.listQuranEntity});
}

class GetQuranError extends GetQuranState {
  final Failure failure;
  const GetQuranError(this.failure);
}
