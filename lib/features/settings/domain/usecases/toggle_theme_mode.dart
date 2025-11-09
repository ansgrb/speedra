import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:speedra/core/errors/failures.dart';
import 'package:speedra/features/settings/domain/repositories/settings_repository.dart';

class ToggleThemeMode {
  final SettingsRepository repository;

  ToggleThemeMode(this.repository);

  Future<Either<Failure, void>> call(ThemeMode currentMode) async {
    final newMode = currentMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    return await repository.setThemeMode(newMode);
  }
}
