import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canScore = context.watch<AppState>().canScore;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Performance', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        const Card(
          child: ListTile(
            title: Text('Composite score'),
            subtitle: Text('Attendance 40% + Tasks/Forms 40% + Observation 20%'),
            trailing: Text('--'),
          ),
        ),
        const SizedBox(height: 12),
        if (canScore)
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_note),
            label: const Text('Enter manager score'),
          )
        else
          const Text('Scores are view-only for this role.'),
      ],
    );
  }
}
