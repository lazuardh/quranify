part of 'get_artists_cubit.dart';

abstract class GetArtistsState extends Equatable {
  const GetArtistsState();

  @override
  List<Object?> get props => [];
}

class GetArtistsInitial extends GetArtistsState {}

class GetArtistsLoading extends GetArtistsState {}

class GetArtistsLoaded extends GetArtistsState {
  final List<ArtistEntity>? artists;
  final List<ArtistEntity>? filtered;
  const GetArtistsLoaded({required this.artists, required this.filtered});

  @override
  List<Object?> get props => [artists, filtered];
}

class GetArtistsError extends GetArtistsState {
  final Failure message;
  const GetArtistsError(this.message);

  @override
  List<Object> get props => [message];
}
