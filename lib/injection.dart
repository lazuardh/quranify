import 'package:get_it/get_it.dart';
import 'package:quranify/lib.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> init() async {
  await _core();
  _quran();
  _surah();
}

Future<void> _core() async {
  getIt.registerLazySingleton<http.Client>(() => http.Client());
}

void _quran() {
  getIt.registerLazySingleton(() => AllSongsRemoteDataSource(getIt()));
  getIt.registerLazySingleton(() => AllSongsRepository(getIt()));
  getIt.registerFactory(() => GetQuranCubit(getIt()));
}

void _surah() {
  getIt.registerFactory(() => GetSurahCubit(getIt()));
}
