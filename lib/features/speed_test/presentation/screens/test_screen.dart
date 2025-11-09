import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:speedra/features/connectivity/presentation/bloc/connectivity_bloc.dart';
import 'package:speedra/features/connectivity/presentation/bloc/connectivity_state.dart';
import 'package:speedra/features/speed_test/presentation/providers/speed_test_provider.dart';
import 'package:speedra/features/speed_test/presentation/widgets/test/metric_card.dart';
import 'package:speedra/features/speed_test/presentation/widgets/test/start_button.dart';
import 'package:speedra/features/speed_test/presentation/widgets/test/test_progress_indicator.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SpeedTestProvider>();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (provider.errorMessage != null)
              _buildErrorMessage(context, provider.errorMessage!),

            const SizedBox(height: 20),

            if (!provider.isTesting && provider.currentDownload == null)
              StartButton(onPressed: () {
                final connectivityState = context.read<ConnectivityBloc>().state;
                if (connectivityState is ConnectivityFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please check your internet connection'),
                    ),
                  );
                } else {
                  provider.performSpeedTest();
                }
              })
            else
              _buildTestResults(context, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestResults(BuildContext context, SpeedTestProvider provider) {
    return Column(
      children: [
        if (provider.isTesting)
          TestProgressIndicator(phase: provider.testingPhase),

        const SizedBox(height: 24),

        MetricCard(
          label: 'PING',
          value: provider.currentPing?.toString() ?? '--',
          unit: 'ms',
          isLoading: provider.isTesting && provider.currentPing == null,
        ),

        const SizedBox(height: 16),

        MetricCard(
          label: 'DOWNLOAD',
          value: provider.currentDownload?.toStringAsFixed(1) ?? '--',
          unit: 'Mbps',
          isLoading: provider.isTesting && provider.currentDownload == null,
        ),

        const SizedBox(height: 16),

        MetricCard(
          label: 'UPLOAD',
          value: provider.currentUpload?.toStringAsFixed(1) ?? '--',
          unit: 'Mbps',
          isLoading: provider.isTesting && provider.currentUpload == null,
        ),

        const SizedBox(height: 32),

        if (!provider.isTesting && provider.currentDownload != null)
          FilledButton.icon(
            onPressed: () {
              final connectivityState = context.read<ConnectivityBloc>().state;
              if (connectivityState is ConnectivityFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please check your internet connection'),
                  ),
                );
              } else {
                provider.performSpeedTest();
              }
            },
            icon: const Icon(Icons.refresh),
            label: const Text('TEST AGAIN'),
          ),
      ],
    );
  }
}
