import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  final SharedPreferencesWithCache prefs;
  final ArtistRepository artists;
  GetDataCubit({required this.prefs, required this.artists})
    : super(const GetDataState());

  static const String _identifierKey = 'identifier';
  static const String _numberKey = 'number';
  static const String _nameKey = 'name';

  void load() async {
    String? identifier = prefs.getString(_identifierKey);

    final response = await artists.getArtists();

    if (identifier == null) {
      identifier = response.fold(
        (_) => null,
        (r) => r.data?.firstOrNull?.identifier,
      );

      if (identifier != null) {
        await prefs.setString(_identifierKey, identifier);
      }
    }

    String? name = prefs.getString(_nameKey);

    if (name == null) {
      name = response.fold(
        (_) => null,
        (r) => r.data?.firstOrNull?.englishName,
      );

      if (name != null) {
        await prefs.setString(_nameKey, name);
      }
    }

    final number = prefs.getInt(_numberKey) ?? 1;

    emit(
      state.copyWith(identifier: identifier, numberSurah: number, name: name),
    );
  }

  Future<void> setIdentifier({required String identifier}) async {
    await prefs.setString(_identifierKey, identifier);

    emit(state.copyWith(identifier: identifier));
  }

  Future<void> setName({required String name}) async {
    await prefs.setString(_nameKey, name);

    emit(state.copyWith(name: name));
  }

  Future<void> setNumberSurah({required int? numberSurah}) async {
    if (numberSurah == null) return;

    await prefs.setInt(_numberKey, numberSurah);

    emit(state.copyWith(numberSurah: numberSurah));
  }
}
