import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:speedra/core/error/exceptions.dart';
import 'package:speedra/core/error/failures.dart';
import 'package:speedra/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:speedra/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, ThemeMode>> getThemeMode() async {
    try {
      final mode = await localDataSource.getThemeMode();
      return Right(mode);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode) async {
    try {
      await localDataSource.setThemeMode(mode);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
