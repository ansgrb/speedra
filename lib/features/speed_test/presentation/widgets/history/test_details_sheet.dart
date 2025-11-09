import 'package:flutter/material.dart';
import 'package:speedra/core/utils/data_formatter.dart';
import 'package:speedra/features/speed_test/domain/entities/speed_test.dart';

class TestDetailsSheet extends StatelessWidget {
  final SpeedTest test;

  const TestDetailsSheet({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test Details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Date'),
                  subtitle: Text(DateFormatter.formatFull(test.timestamp)),
                ),
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Download Speed'),
                  subtitle: Text('${test.downloadSpeed.toStringAsFixed(2)} Mbps'),
                ),
                ListTile(
                  leading: const Icon(Icons.upload),
                  title: const Text('Upload Speed'),
                  subtitle: Text('${test.uploadSpeed.toStringAsFixed(2)} Mbps'),
                ),
                ListTile(
                  leading: const Icon(Icons.speed),
                  title: const Text('Ping'),
                  subtitle: Text('${test.ping} ms'),
                ),
                if (test.label != null)
                  ListTile(
                    leading: const Icon(Icons.label),
                    title: const Text('Label'),
                    subtitle: Text(test.label!),
                  ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
