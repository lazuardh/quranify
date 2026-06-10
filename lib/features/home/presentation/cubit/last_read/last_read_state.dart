part of 'last_read_cubit.dart';

sealed class LastReadState extends Equatable {
  const LastReadState();

  @override
  List<Object> get props => [];
}

final class LastReadInitial extends LastReadState {}

class LastReadLoading extends LastReadState {}

class LastReadEmpty extends LastReadState {}

class LastReadLoaded extends LastReadState {
  final LastReadEntity lastRead;
  const LastReadLoaded(this.lastRead);
  @override
  List<Object> get props => [lastRead];
}

class LastReadError extends LastReadState {
  final String message;
  const LastReadError(this.message);

  @override
  List<Object> get props => [message];
}
