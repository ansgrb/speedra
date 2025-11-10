import 'package:dartz/dartz.dart';
import 'package:speedra/core/error/failures.dart';
import 'package:speedra/features/speed_test/domain/entities/speed_test.dart';

abstract class SpeedTestRepository {
  Future<Either<Failure, SpeedTest>> runSpeedTest();
  Future<Either<Failure, List<SpeedTest>>> getSpeedTests();
  Future<Either<Failure, void>> saveSpeedTest(SpeedTest test);
  Future<Either<Failure, void>> updateTestLabel(String id, String? label);
  Future<Either<Failure, void>> toggleFavorite(String id);
  Future<Either<Failure, void>> deleteTest(String id);
}

// Either left: for the failure case right: a success case
