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
        Text('Score', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        const _ScoreBar(label: 'Attendance', value: 0.40, score: '+10 on-time · +5 late ≤30 · -5 absent'),
        const _ScoreBar(label: 'Performance', value: 0.40, score: 'Manager KPI/KRA score'),
        const _ScoreBar(label: 'Observations', value: 0.20, score: '+15 per maintenance observation'),
        const SizedBox(height: 12),
        const Card(
          child: ListTile(
            leading: Icon(Icons.emoji_events_outlined),
            title: Text('Monthly Score'),
            subtitle: Text('(Attendance × 0.40) + (Performance × 0.40) + (Observations × 0.20)'),
            trailing: Text('--'),
          ),
        ),
        const SizedBox(height: 12),
        if (canScore) const _ManagerScoreInput() else const _ReadOnlyNotice(),
      ],
    );
  }
}

class _ScoreBar extends StatelessWidget {
  const _ScoreBar({required this.label, required this.value, required this.score});

  final String label;
  final double value;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            LinearProgressIndicator(value: value, minHeight: 10),
            const SizedBox(height: 8),
            Text(score),
          ],
        ),
      ),
    );
  }
}

class _ManagerScoreInput extends StatelessWidget {
  const _ManagerScoreInput();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Manager score entry', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'KPI/KRA score'),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save score'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadOnlyNotice extends StatelessWidget {
  const _ReadOnlyNotice();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.lock_outline),
        title: Text('View only'),
        subtitle: Text('Only managers can enter performance scores. No save is triggered here.'),
      ),
    );
  }
}
