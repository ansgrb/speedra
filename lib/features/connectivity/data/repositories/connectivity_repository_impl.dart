import 'package:dartz/dartz.dart';
import 'package:speedra/core/error/failures.dart';
import 'package:speedra/features/connectivity/data/datasources/connectivity_datasource.dart';
import 'package:speedra/features/connectivity/domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final ConnectivityDataSource dataSource;

  ConnectivityRepositoryImpl(this.dataSource);

  @override
  Stream<Either<Failure, bool>> get isConnected {
    return dataSource.isConnected.map((isConnected) {
      if (isConnected) {
        return Right(isConnected);
      } else {
        return Left(const NetworkFailure('No internet connection'));
      }
    });
  }
}
