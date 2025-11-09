import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:speedra/core/errors/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, ThemeMode>> getThemeMode();
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode);
}
