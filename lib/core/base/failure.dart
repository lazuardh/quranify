import 'package:equatable/equatable.dart';
import 'package:quranify/lib.dart';

class Failure extends Equatable {
  final String message;
  final BaseApiResponseEntity? error;

  const Failure({required this.message, this.error});

  @override
  List<Object?> get props => [message, error];

  @override
  bool get stringify => true;
}
