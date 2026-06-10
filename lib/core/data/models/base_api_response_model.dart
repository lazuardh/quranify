import 'package:quranify/lib.dart';

class BaseApiResponseModel<T> {
  final String status;
  final int code;
  final T? data;
  final String message;

  const BaseApiResponseModel({
    required this.status,
    required this.code,
    this.data,
    this.message = '',
  });

  factory BaseApiResponseModel.fromJson(
    Map<String, dynamic> json, {
    T? Function(dynamic response)? generateData,
  }) {
    if ((json['status'] as String? ?? "-1").toUpperCase() != "OK") {
      throw RemoteException(message: json['message'] as String?);
    }

    return BaseApiResponseModel(
      status: json['status'] as String? ?? '',
      code: json['code'] as int? ?? 0,
      data: generateData == null ? null : generateData(json['data']),
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T? data) generateData) => {
    'status': status,
    'code': code,
    'data': generateData(data),
  };
}
