import 'package:dartz/dartz.dart';

import '../../lib.dart';

mixin class BaseRepository {
  Future<Either<Failure, T>> catchOrThrow<T>(Future<T> Function() body) async {
    try {
      final data = await body();

      return Right(data);
    } on BaseException catch (e) {
      return Left(
        Failure(
          message: e.message ?? MessageConstant.defaultErrorMessage,
          error: (e is RemoteException) ? e.error : null,
        ),
      );
    } catch (e) {
      return const Left(Failure(message: MessageConstant.defaultErrorMessage));
    }
  }
}
