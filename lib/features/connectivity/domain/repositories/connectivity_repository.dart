import 'package:dartz/dartz.dart';
import 'package:speedra/core/errors/failures.dart';

abstract class ConnectivityRepository {
  Stream<Either<Failure, bool>> get isConnected;
}
