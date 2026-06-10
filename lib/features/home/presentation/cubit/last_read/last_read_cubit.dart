import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranify/lib.dart';

part 'last_read_state.dart';

class LastReadCubit extends Cubit<LastReadState> {
  final LastReadRepository repository;
  LastReadCubit(this.repository) : super(LastReadInitial());

  void loadLastRead() {
    final data = repository.getLastRead();

    if (data == null) {
      emit(LastReadEmpty());
    } else {
      emit(LastReadLoaded(data));
    }
  }

  Future<void> saveLastRead(LastReadEntity entity) async {
    emit(LastReadLoading());

    try {
      await repository.saveLastRead(entity);

      emit(LastReadLoaded(entity));
    } catch (e) {
      emit(LastReadError(e.toString()));
    }
  }
}
