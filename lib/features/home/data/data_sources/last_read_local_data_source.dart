import 'dart:convert';

import 'package:quranify/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastReadLocalDataSource {
  final SharedPreferences prefs;

  const LastReadLocalDataSource(this.prefs);

  static const _key = 'last_read';

  Future<void> saveLastRead(LastReadModel model) async {
    await prefs.setString(_key, jsonEncode(model.toJson()));
  }

  LastReadModel? getLastRead() {
    final data = prefs.getString(_key);

    if (data == null) return null;

    return LastReadModel.fromJson(jsonDecode(data));
  }
}
