import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

part 'get_artists_state.dart';

class GetArtistsCubit extends Cubit<GetArtistsState> {
  final ArtistRepository _repository;
  GetArtistsCubit(this._repository) : super(GetArtistsInitial());

  List<ArtistEntity> _artists = [];

  Future<void> getArtists() async {
    emit(GetArtistsLoading());

    final response = await _repository.getArtists();
    emit(
      response.fold((failure) => GetArtistsError(failure), (list) {
        _artists = list.data ?? [];
        return GetArtistsLoaded(artists: _artists, filtered: _artists);
      }),
    );
  }

  void searchArtists(String keyword) {
    if (state is! GetArtistsLoaded) return;

    final query = keyword.trim().toLowerCase();

    if (query.isEmpty) {
      emit(GetArtistsLoaded(artists: _artists, filtered: _artists));
      return;
    }

    final filtered = _artists.where((artist) {
      return artist.name.toLowerCase().contains(query);
    }).toList();

    emit(GetArtistsLoaded(artists: _artists, filtered: filtered));
  }
}
