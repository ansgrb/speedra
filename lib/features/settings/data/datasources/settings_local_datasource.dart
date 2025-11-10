import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedra/core/constants/storage_keys.dart';
import 'package:speedra/core/error/exceptions.dart';

abstract class SettingsLocalDataSource {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<ThemeMode> getThemeMode() async {
    try {
      final modeString = sharedPreferences.getString(StorageKeys.themeMode);
      if (modeString == null) return ThemeMode.system;

      return ThemeMode.values.firstWhere(
        (mode) => mode.toString() == modeString,
        orElse: () => ThemeMode.system,
      );
    } catch (e) {
      throw CacheException('Failed to load theme mode: ${e.toString()}');
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      await sharedPreferences.setString(StorageKeys.themeMode, mode.toString());
    } catch (e) {
      throw CacheException('Failed to save theme mode: ${e.toString()}');
    }
  }
}
