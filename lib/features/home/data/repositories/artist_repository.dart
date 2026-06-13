import 'package:dartz/dartz.dart';
import 'package:quranify/lib.dart';

class ArtistRepository with BaseRepository {
  final ArtistRemoteDataSource _dataSource;
  ArtistRepository(this._dataSource);

  Future<Either<Failure, BaseApiResponseEntity<List<ArtistEntity>>>>
  getArtists() {
    return catchOrThrow(() async {
      final response = await _dataSource.fetchArtist();

      return BaseApiResponseEntity.fromBaseApiResponseModel(
        response,
        data: response.data?.map((e) => e.toEntity()).toList(),
      );
    });
  }
}
