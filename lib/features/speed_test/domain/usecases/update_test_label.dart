import 'package:dartz/dartz.dart';
import 'package:speedra/core/errors/failures.dart';
import 'package:speedra/features/speed_test/domain/repositories/speed_test_repository.dart';

class UpdateTestLabel {
  final SpeedTestRepository repository;

  UpdateTestLabel(this.repository);

  Future<Either<Failure, void>> call(String id, String? label) async {
    return await repository.updateTestLabel(id, label);
  }
}
