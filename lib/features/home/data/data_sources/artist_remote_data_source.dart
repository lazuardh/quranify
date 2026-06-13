import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quranify/lib.dart';

class ArtistRemoteDataSource with BaseDataResource {
  final http.Client client;
  ArtistRemoteDataSource(this.client);

  Future<BaseApiResponseModel<List<ArtistModel>>> fetchArtist() async {
    return httpCatchOrThrow(() async {
      final response = await client.get(Uri.parse(UrlConstant.artist));

      final json = jsonDecode(response.body);

      return BaseApiResponseModel.fromJson(
        json,
        generateData: (response) => List<ArtistModel>.from(
          (response as List).map(
            (e) => ArtistModel.fromJson(e as Map<String, Object?>),
          ),
        ),
      );
    });
  }
}
