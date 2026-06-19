import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final LastReadRepository _repository;
  BookmarkCubit(this._repository) : super(BookmarkInitial());

  void load() {
    final data = _repository.getBookmark();

    if (data == null) {
      emit(GetBookmarkEmpty());
    } else {
      emit(GetBookmarkLoaded(data));
    }
  }

  Future<void> saveBookmark(BookmarkEntity entity) async {
    emit(GetBookmarkLoading());

    try {
      await _repository.saveBookmark(entity);

      emit(GetBookmarkLoaded(entity));
    } catch (e) {
      emit(GetBookmarkError(e.toString()));
    }
  }
}
