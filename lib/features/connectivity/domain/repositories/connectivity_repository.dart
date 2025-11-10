import 'package:dartz/dartz.dart';
import 'package:speedra/core/error/failures.dart';

abstract class ConnectivityRepository {
  Stream<Either<Failure, bool>> get isConnected;
}
