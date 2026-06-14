import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quranify/lib.dart';

class AllSongsRemoteDataSource with BaseDataResource {
  final http.Client client;
  AllSongsRemoteDataSource(this.client);

  Future<BaseApiResponseModel<List<QuranModel>>> fetchDataApi() async {
    return httpCatchOrThrow(() async {
      final response = await client.get(Uri.parse(UrlConstant.surah));

      final json = jsonDecode(response.body);

      return BaseApiResponseModel.fromJson(
        json,
        generateData: (data) => List<QuranModel>.from(
          (data as List).map(
            (e) => QuranModel.fromJson(e as Map<String, Object?>),
          ),
        ),
      );
    });
  }

  Future<BaseApiResponseModel<SurahModel>> fetchDataSurah(int? number) async {
    return httpCatchOrThrow(() async {
      final query =
          '${UrlConstant.surah}/$number/editions/quran-uthmani,id.indonesian';
      final response = await client.get(Uri.parse(query));

      final json = jsonDecode(response.body);

      return BaseApiResponseModel.fromJson(
        json,
        generateData: (data) =>
            SurahModel.fromEditionJson(data as List<dynamic>),
      );
    });
  }

  Future<BaseApiResponseModel<AudioSurahModel>> fetchAudioSurah({
    required int number,
    required String artist,
  }) async {
    return httpCatchOrThrow(() async {
      final response = await client.get(
        Uri.parse('${UrlConstant.surah}/$number/$artist'),
      );

      final json = jsonDecode(response.body);

      return BaseApiResponseModel.fromJson(
        json,
        generateData: (response) =>
            AudioSurahModel.fromJson(response as Map<String, Object?>),
      );
    });
  }
}
