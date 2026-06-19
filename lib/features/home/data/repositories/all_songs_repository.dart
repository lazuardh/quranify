import 'package:dartz/dartz.dart';

import '../../../../lib.dart';

class AllSongsRepository with BaseRepository {
  final AllSongsRemoteDataSource _remoteDataSource;

  AllSongsRepository(this._remoteDataSource);

  Future<Either<Failure, BaseApiResponseEntity<List<QuranEntity>>>>
  getQuranApi() {
    return catchOrThrow(() async {
      final response = await _remoteDataSource.fetchDataApi();

      return BaseApiResponseEntity.fromBaseApiResponseModel(
        response,
        data: response.data?.map((e) => e.toEntity()).toList(),
      );
    });
  }

  Future<Either<Failure, BaseApiResponseEntity<SurahEntity>>> getSurahApi(
    int? number,
  ) {
    return catchOrThrow(() async {
      final response = await _remoteDataSource.fetchDataSurah(number);

      return BaseApiResponseEntity.fromBaseApiResponseModel(
        response,
        data: response.data?.toEntity(),
      );
    });
  }

  Future<Either<Failure, BaseApiResponseEntity<AudioSurahEntity>>>
  getAudioSurahApi({required int number, required String artist}) {
    return catchOrThrow(() async {
      final response = await _remoteDataSource.fetchAudioSurah(
        number: number,
        artist: artist,
      );

      return BaseApiResponseEntity.fromBaseApiResponseModel(
        response,
        data: response.data?.toEntity(),
      );
    });
  }
}
