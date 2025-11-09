import 'package:dartz/dartz.dart';
import 'package:speedra/core/errors/failures.dart';
import 'package:speedra/features/speed_test/domain/repositories/speed_test_repository.dart';

class DeleteTest {
  final SpeedTestRepository repository;

  DeleteTest(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteTest(id);
  }
}
