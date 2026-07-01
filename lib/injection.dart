import 'package:get_it/get_it.dart';
import 'package:quranify/lib.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await _core();
  _quran();
  _surah();
  _lastRead();
  _artists();
  _audio();
  _getData();
  _homeTab();
  _bookmark();
  _specchToText();
}

Future<void> _core() async {
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  final sharedPreferences = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: <String>{
        'identifier',
        'number',
        'last_read',
        'name',
        'bookmark',
      },
    ),
  );

  getIt.registerLazySingleton<SharedPreferencesWithCache>(
    () => sharedPreferences,
  );
}

void _quran() {
  getIt.registerLazySingleton(() => AllSongsRemoteDataSource(getIt()));
  getIt.registerLazySingleton(() => AllSongsRepository(getIt()));
  getIt.registerFactory(() => GetQuranCubit(getIt()));
}

void _surah() {
  getIt.registerFactory(() => GetSurahCubit(getIt()));
}

void _lastRead() {
  getIt.registerLazySingleton(() => LastReadLocalDataSource(getIt()));
  getIt.registerLazySingleton<LastReadRepository>(
    () => LastReadRepositoryImpl(getIt()),
  );
  getIt.registerFactory(() => LastReadCubit(getIt()));
}

void _artists() {
  getIt.registerLazySingleton(() => ArtistRemoteDataSource(getIt()));
  getIt.registerLazySingleton(() => ArtistRepository(getIt()));
  getIt.registerFactory(() => GetArtistsCubit(getIt()));
}

void _audio() {
  getIt.registerFactory(() => GetAudioCubit(getIt()));
  getIt.registerFactory(() => AudioPlayerCubit());
}

void _getData() {
  getIt.registerFactory(() => GetDataCubit(prefs: getIt(), artists: getIt()));
}

void _homeTab() {
  getIt.registerFactory(() => HomeCubit());
}

void _bookmark() {
  getIt.registerFactory(() => BookmarkCubit(getIt()));
}

void _specchToText() {
  getIt.registerFactory(() => SpeechToTextCubit());
}
