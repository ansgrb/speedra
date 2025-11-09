import 'package:dartz/dartz.dart';
import 'package:speedra/core/errors/exceptions.dart';
import 'package:speedra/core/errors/failures.dart';
import 'package:speedra/features/speed_test/data/datasources/speed_test_local_datasource.dart';
import 'package:speedra/features/speed_test/data/datasources/speed_test_remote_datasource.dart';
import 'package:speedra/features/speed_test/data/models/speed_test_model.dart';
import 'package:speedra/features/speed_test/domain/entities/speed_test.dart';
import 'package:speedra/features/speed_test/domain/repositories/speed_test_repository.dart';

class SpeedTestRepositoryImpl implements SpeedTestRepository {
  final SpeedTestLocalDataSource localDataSource;
  final SpeedTestRemoteDataSource remoteDataSource;

  SpeedTestRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, SpeedTest>> runSpeedTest() async {
    try {
      // Measure ping
      final ping = await remoteDataSource.measurePing();

      // Measure download
      final downloadSpeed = await remoteDataSource.measureDownloadSpeed();

      // Measure upload
      final uploadSpeed = await remoteDataSource.measureUploadSpeed();

      // Create test result
      final test = SpeedTestModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        downloadSpeed: downloadSpeed,
        uploadSpeed: uploadSpeed,
        ping: ping,
      );

      // Cache the result
      await localDataSource.cacheSpeedTest(test);

      return Right(test);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<SpeedTest>>> getSpeedTests() async {
    try {
      final tests = await localDataSource.getCachedSpeedTests();
      return Right(tests);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveSpeedTest(SpeedTest test) async {
    try {
      final model = SpeedTestModel.fromEntity(test);
      await localDataSource.cacheSpeedTest(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTestLabel(
    String id,
    String? label,
  ) async {
    try {
      await localDataSource.updateTestLabel(id, label);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String id) async {
    try {
      await localDataSource.toggleFavorite(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTest(String id) async {
    try {
      await localDataSource.deleteTest(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
