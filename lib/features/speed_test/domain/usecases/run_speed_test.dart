import 'package:dartz/dartz.dart';
import 'package:speedra/core/error/failures.dart';
import 'package:speedra/features/speed_test/domain/entities/speed_test.dart';
import 'package:speedra/features/speed_test/domain/repositories/speed_test_repository.dart';

class RunSpeedTest {
  final SpeedTestRepository repository;

  RunSpeedTest(this.repository);

  Future<Either<Failure, SpeedTest>> call() async {
    return await repository.runSpeedTest();
  }
}
