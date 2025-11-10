import 'package:dartz/dartz.dart';
import 'package:speedra/core/error/failures.dart';
import 'package:speedra/features/speed_test/domain/repositories/speed_test_repository.dart';

class ToggleFavorite {
  final SpeedTestRepository repository;

  ToggleFavorite(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.toggleFavorite(id);
  }
}
