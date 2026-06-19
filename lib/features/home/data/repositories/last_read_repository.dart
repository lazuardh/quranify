import 'package:quranify/lib.dart';

abstract class LastReadRepository {
  Future<void> saveLastRead(LastReadEntity read);
  LastReadEntity? getLastRead();
  Future<void> saveBookmark(BookmarkEntity save);
  BookmarkEntity? getBookmark();
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

  @override
  BookmarkEntity? getBookmark() {
    return local.getLastBookmark()?.toEntity();
  }

  @override
  Future<void> saveBookmark(BookmarkEntity save) async {
    await local.saveBookmark(
      BookmarkModel(
        number: save.number,
        name: save.name,
        arabicText: save.arabicText,
        translationText: save.translationText,
        ayahNumber: save.ayahNumber,
        createdAt: save.createdAt,
      ),
    );
  }
}
