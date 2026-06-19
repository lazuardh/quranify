part of 'bookmark_cubit.dart';

sealed class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

final class BookmarkInitial extends BookmarkState {}

class GetBookmarkLoading extends BookmarkState {}

class GetBookmarkEmpty extends BookmarkState {}

class GetBookmarkLoaded extends BookmarkState {
  final BookmarkEntity bookmark;
  const GetBookmarkLoaded(this.bookmark);
  @override
  List<Object> get props => [bookmark];
}

class GetBookmarkError extends BookmarkState {
  final String message;
  const GetBookmarkError(this.message);

  @override
  List<Object> get props => [message];
}
