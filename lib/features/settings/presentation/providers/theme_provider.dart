import 'package:flutter/material.dart';
import 'package:speedra/core/theme/app_theme.dart';
import 'package:speedra/features/settings/domain/usecases/get_theme_mode.dart';
import 'package:speedra/features/settings/domain/usecases/toggle_theme_mode.dart';

class ThemeProvider extends ChangeNotifier {
  final GetThemeMode getThemeMode;
  final ToggleThemeMode toggleThemeMode;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider({required this.getThemeMode, required this.toggleThemeMode}) {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _loadThemeMode() async {
    final result = await getThemeMode();
    result.fold(
      (failure) => _themeMode = ThemeMode.system,
      (mode) => _themeMode = mode,
    );
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final result = await toggleThemeMode(_themeMode);
    result.fold(
      (failure) {
        // Handle error if needed
      },
      (_) {
        _themeMode = _themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
      },
    );
    notifyListeners();
  }
}
