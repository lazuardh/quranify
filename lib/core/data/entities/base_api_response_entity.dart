import 'package:equatable/equatable.dart';

import '../../../lib.dart';

class BaseApiResponseEntity<T> extends Equatable {
  final String status;
  final int code;
  final T? data;

  const BaseApiResponseEntity({
    required this.status,
    required this.code,
    this.data,
  });

  factory BaseApiResponseEntity.fromBaseApiResponseModel(
    BaseApiResponseModel response, {
    T? data,
  }) => BaseApiResponseEntity(
    status: response.status,
    code: response.code,
    data: data,
  );

  BaseApiResponseEntity<T> copyWith({String? status, int? code, T? data}) {
    return BaseApiResponseEntity<T>(
      status: status ?? this.status,
      code: code ?? this.code,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, code, data];
}
