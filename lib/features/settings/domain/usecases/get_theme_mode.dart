import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:speedra/core/errors/failures.dart';
import 'package:speedra/features/settings/domain/repositories/settings_repository.dart';

class GetThemeMode {
  final SettingsRepository repository;

  GetThemeMode(this.repository);

  Future<Either<Failure, ThemeMode>> call() async {
    return await repository.getThemeMode();
  }
}
