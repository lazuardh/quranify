import 'package:quranify/lib.dart';

abstract class LastReadRepository {
  Future<void> saveLastRead(LastReadEntity read);
  LastReadEntity? getLastRead();
}

class LastReadRepositoryImpl implements LastReadRepository {
  final LastReadLocalDataSource local;
  const LastReadRepositoryImpl(this.local);

  @override
  LastReadEntity? getLastRead() {
    return local.getLastRead()?.toEntity();
  }

  @override
  Future<void> saveLastRead(LastReadEntity entity) async {
    await local.saveLastRead(
      LastReadModel(
        surahNumber: entity.surahNumber,
        surahName: entity.surahName,
        ayahNumber: entity.ayahNumber,
      ),
    );
  }
}
