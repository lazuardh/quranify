part of 'home_cubit_cubit.dart';

class HomeCubitState extends Equatable {
  final HomeTab selectedTab;
  const HomeCubitState({required this.selectedTab});

  HomeCubitState copyWith({HomeTab? selectedTab}) {
    return HomeCubitState(selectedTab: selectedTab ?? this.selectedTab);
  }

  @override
  List<Object> get props => [selectedTab];
}
