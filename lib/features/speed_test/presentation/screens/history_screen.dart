import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedra/features/speed_test/presentation/providers/speed_test_provider.dart';
import 'package:speedra/features/speed_test/presentation/widgets/history/empty_history_view.dart';
import 'package:speedra/features/speed_test/presentation/widgets/history/history_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SpeedTestProvider>();

    if (provider.speedTests.isEmpty) {
      return const EmptyHistoryView();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.speedTests.length,
      itemBuilder: (context, index) {
        return HistoryCard(
          test: provider.speedTests[index],
          index: index,
          onToggleFavorite: () {
            provider.toggleTestFavorite(provider.speedTests[index].id);
          },
          onUpdateLabel: (label) {
            provider.updateLabel(provider.speedTests[index].id, label);
          },
          onDelete: () {
            provider.removeTest(provider.speedTests[index].id);
          },
        );
      },
    );
  }
}
