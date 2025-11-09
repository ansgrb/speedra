import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedra/core/constants/storage_keys.dart';
import 'package:speedra/core/errors/exceptions.dart';
import 'package:speedra/features/speed_test/data/models/speed_test_model.dart';

abstract class SpeedTestLocalDataSource {
  Future<List<SpeedTestModel>> getCachedSpeedTests();
  Future<void> cacheSpeedTests(List<SpeedTestModel> tests);
  Future<void> cacheSpeedTest(SpeedTestModel test);
  Future<void> updateTestLabel(String id, String? label);
  Future<void> toggleFavorite(String id);
  Future<void> deleteTest(String id);
}

class SpeedTestLocalDataSourceImpl implements SpeedTestLocalDataSource {
  final SharedPreferences sharedPreferences;

  SpeedTestLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<SpeedTestModel>> getCachedSpeedTests() async {
    try {
      final jsonString = sharedPreferences.getString(StorageKeys.speedTests);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => SpeedTestModel.fromJson(json)).toList();
    } catch (e) {
      throw CacheException('Failed to load speed tests: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheSpeedTests(List<SpeedTestModel> tests) async {
    try {
      final jsonString = json.encode(
        tests.map((test) => test.toJson()).toList(),
      );
      await sharedPreferences.setString(StorageKeys.speedTests, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache speed tests: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheSpeedTest(SpeedTestModel test) async {
    try {
      final tests = await getCachedSpeedTests();
      tests.insert(0, test);
      await cacheSpeedTests(tests);
    } catch (e) {
      throw CacheException('Failed to cache speed test: ${e.toString()}');
    }
  }

  @override
  Future<void> updateTestLabel(String id, String? label) async {
    try {
      final tests = await getCachedSpeedTests();
      final index = tests.indexWhere((test) => test.id == id);
      if (index != -1) {
        final updatedTest = SpeedTestModel(
          id: tests[index].id,
          timestamp: tests[index].timestamp,
          downloadSpeed: tests[index].downloadSpeed,
          uploadSpeed: tests[index].uploadSpeed,
          ping: tests[index].ping,
          label: label,
          isFavorite: tests[index].isFavorite,
        );
        tests[index] = updatedTest;
        await cacheSpeedTests(tests);
      }
    } catch (e) {
      throw CacheException('Failed to update test label: ${e.toString()}');
    }
  }

  @override
  Future<void> toggleFavorite(String id) async {
    try {
      final tests = await getCachedSpeedTests();
      final index = tests.indexWhere((test) => test.id == id);
      if (index != -1) {
        final updatedTest = SpeedTestModel(
          id: tests[index].id,
          timestamp: tests[index].timestamp,
          downloadSpeed: tests[index].downloadSpeed,
          uploadSpeed: tests[index].uploadSpeed,
          ping: tests[index].ping,
          label: tests[index].label,
          isFavorite: !tests[index].isFavorite,
        );
        tests[index] = updatedTest;
        await cacheSpeedTests(tests);
      }
    } catch (e) {
      throw CacheException('Failed to toggle favorite: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTest(String id) async {
    try {
      final tests = await getCachedSpeedTests();
      tests.removeWhere((test) => test.id == id);
      await cacheSpeedTests(tests);
    } catch (e) {
      throw CacheException('Failed to delete test: ${e.toString()}');
    }
  }
}
