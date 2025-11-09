import 'package:flutter/material.dart';
import 'package:speedra/features/speed_test/domain/entities/speed_test.dart';
import 'package:speedra/features/speed_test/domain/usecases/delete_test.dart';
import 'package:speedra/features/speed_test/domain/usecases/get_speed_tests.dart';
import 'package:speedra/features/speed_test/domain/usecases/run_speed_test.dart';
import 'package:speedra/features/speed_test/domain/usecases/toggle_favorite.dart';
import 'package:speedra/features/speed_test/domain/usecases/update_test_label.dart';

class SpeedTestProvider extends ChangeNotifier {
  final RunSpeedTest runSpeedTest;
  final GetSpeedTests getSpeedTests;
  final UpdateTestLabel updateTestLabel;
  final ToggleFavorite toggleFavorite;
  final DeleteTest deleteTest;

  SpeedTestProvider({
    required this.runSpeedTest,
    required this.getSpeedTests,
    required this.updateTestLabel,
    required this.toggleFavorite,
    required this.deleteTest,
  }) {
    loadTests();
  }

  List<SpeedTest> _speedTests = [];
  bool _isTesting = false;
  double? _currentDownload;
  double? _currentUpload;
  int? _currentPing;
  String _testingPhase = '';
  String? _errorMessage;

  List<SpeedTest> get speedTests => _speedTests;
  bool get isTesting => _isTesting;
  double? get currentDownload => _currentDownload;
  double? get currentUpload => _currentUpload;
  int? get currentPing => _currentPing;
  String get testingPhase => _testingPhase;
  String? get errorMessage => _errorMessage;

  Future<void> loadTests() async {
    final result = await getSpeedTests();
    result.fold((failure) => _errorMessage = failure.message, (tests) {
      _speedTests = tests;
      _errorMessage = null;
    });
    notifyListeners();
  }

  Future<void> performSpeedTest() async {
    _isTesting = true;
    _currentDownload = null;
    _currentUpload = null;
    _currentPing = null;
    _errorMessage = null;
    notifyListeners();

    try {
      // Testing ping
      _testingPhase = 'Testing ping...';
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));

      // Run the actual speed test
      final result = await runSpeedTest();

      await result.fold(
        (failure) async {
          _errorMessage = failure.message;
        },
        (test) async {
          _currentPing = test.ping;
          _testingPhase = 'Testing download...';
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 500));

          _currentDownload = test.downloadSpeed;
          _testingPhase = 'Testing upload...';
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 500));

          _currentUpload = test.uploadSpeed;

          // Add to list
          _speedTests.insert(0, test);
        },
      );
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      _isTesting = false;
      _testingPhase = '';
      notifyListeners();
    }
  }

  Future<void> updateLabel(String id, String? label) async {
    final result = await updateTestLabel(id, label);
    result.fold((failure) => _errorMessage = failure.message, (_) {
      final index = _speedTests.indexWhere((test) => test.id == id);
      if (index != -1) {
        final updatedTest = _speedTests[index].copyWith(label: label);
        _speedTests = List.from(_speedTests)..[index] = updatedTest;
        _errorMessage = null;
      }
    });
    notifyListeners();
  }

  Future<void> toggleTestFavorite(String id) async {
    final result = await toggleFavorite(id);
    result.fold((failure) => _errorMessage = failure.message, (_) {
      final index = _speedTests.indexWhere((test) => test.id == id);
      if (index != -1) {
        final updatedTest = _speedTests[index].copyWith(
          isFavorite: !_speedTests[index].isFavorite,
        );
        _speedTests = List.from(_speedTests)..[index] = updatedTest;
        _errorMessage = null;
      }
    });
    notifyListeners();
  }

  Future<void> removeTest(String id) async {
    final result = await deleteTest(id);
    result.fold((failure) => _errorMessage = failure.message, (_) {
      _speedTests.removeWhere((test) => test.id == id);
      _errorMessage = null;
    });
    notifyListeners();
  }
}
