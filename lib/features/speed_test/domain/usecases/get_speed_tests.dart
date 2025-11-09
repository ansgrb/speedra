import 'package:dartz/dartz.dart';
import 'package:speedra/core/errors/failures.dart';
import 'package:speedra/features/speed_test/domain/entities/speed_test.dart';
import 'package:speedra/features/speed_test/domain/repositories/speed_test_repository.dart';

class GetSpeedTests {
  final SpeedTestRepository repository;

  GetSpeedTests(this.repository);

  Future<Either<Failure, List<SpeedTest>>> call() async {
    return await repository.getSpeedTests();
  }
}
