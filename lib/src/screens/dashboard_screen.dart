import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';
import '../widgets/status_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Home', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text('${profile?.name ?? 'Staff'} - ${profile?.department ?? ''}'),
        const SizedBox(height: 16),
        const StatusCard(title: 'Attendance', value: 'Not marked today', icon: Icons.pin_drop_outlined),
        const SizedBox(height: 10),
        const StatusCard(title: 'Due forms', value: '3 pending', icon: Icons.assignment_outlined),
        const SizedBox(height: 10),
        const StatusCard(title: 'Tasks', value: '5 open / 1 overdue', icon: Icons.task_alt_outlined),
        const SizedBox(height: 10),
        const StatusCard(title: 'Performance', value: 'No score submitted', icon: Icons.score_outlined),
      ],
    );
  }
}
