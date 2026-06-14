part of 'get_data_cubit.dart';

class GetDataState extends Equatable {
  final String identifier;
  final String name;
  final int numberSurah;
  final bool isLoading;

  const GetDataState({
    this.identifier = '',
    this.name = '',
    this.numberSurah = 0,
    this.isLoading = false,
  });

  GetDataState copyWith({
    String? identifier,
    String? name,
    int? numberSurah,
    bool? isLoading,
  }) {
    return GetDataState(
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      numberSurah: numberSurah ?? this.numberSurah,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [identifier, name, numberSurah, isLoading];
}
