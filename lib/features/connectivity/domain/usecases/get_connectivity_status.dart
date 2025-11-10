import 'package:dartz/dartz.dart';
import 'package:speedra/core/error/failures.dart';
import 'package:speedra/features/connectivity/domain/repositories/connectivity_repository.dart';

class GetConnectivityStatus {
  final ConnectivityRepository repository;

  GetConnectivityStatus(this.repository);

  Stream<Either<Failure, bool>> call() {
    return repository.isConnected;
  }
}
