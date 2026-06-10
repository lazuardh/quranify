import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quranify/lib.dart';

mixin class BaseDataResource {
  Future<T> httpCatchOrThrow<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on SocketException {
      throw const RemoteException(
        message: MessageConstant.noInternetConnection,
      );
    } on HttpException catch (e) {
      bool checkConnection = await _isHasInternetConnection();
      if (!checkConnection || e.message.contains('SocketException')) {
        throw const RemoteException(
          message: MessageConstant.noInternetConnection,
        );
      }

      throw RemoteException(message: e.message);
    } catch (e) {
      throw e is RemoteException
          ? e
          : const RemoteException(message: MessageConstant.defaultErrorMessage);
    }
  }
}

Future<bool> _isHasInternetConnection() async {
  return await InternetConnectionChecker.instance.hasConnection;
}
