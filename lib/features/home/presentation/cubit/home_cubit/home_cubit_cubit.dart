import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(const HomeCubitState(selectedTab: HomeTab.surah));

  void changedTab(HomeTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}

enum HomeTab { surah, juz, bookmark }
