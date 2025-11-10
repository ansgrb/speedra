import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:speedra/features/connectivity/presentation/bloc/connectivity_bloc.dart';
import 'package:speedra/features/settings/presentation/providers/theme_provider.dart';
import 'package:speedra/features/speed_test/presentation/providers/speed_test_provider.dart';
import 'package:speedra/features/speed_test/presentation/screens/home_screen.dart';
import 'package:speedra/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies (DI, SharedPreferences, etc.)
  await di.init();

  runApp(const SpeedTestApp());
}

class SpeedTestApp extends StatelessWidget {
  const SpeedTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide both ThemeProvider and SpeedTestProvider to the widget tree
    return MultiProvider(
      providers: [
        // Settings Provider (Theme Management)
        ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>()),

        // Speed Test Provider (Main app functionality)
        ChangeNotifierProvider(create: (_) => di.sl<SpeedTestProvider>()),

        // Connectivity Provider (Network Status)
        BlocProvider(create: (_) => di.sl<ConnectivityBloc>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            // App Configuration
            title: 'Speed Test',
            debugShowCheckedModeBanner: false,

            // Theme Configuration
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,

            // Home Screen
            home: const HomeScreen(),

            // Optional: Custom routes if needed
            // routes: {
            //   '/test': (context) => const TestScreen(),
            //   '/history': (context) => const HistoryScreen(),
            // },
          );
        },
      ),
    );
  }
}
