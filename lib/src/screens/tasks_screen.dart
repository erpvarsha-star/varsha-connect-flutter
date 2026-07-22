import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AppState>().profile?.role ?? 'worker';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Tasks', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        if (role == 'worker') const _WorkerChecklist(),
        if (role == 'supervisor') const _SupervisorTeamConfirm(),
        if (role == 'manager') const _ManagerApprovals(),
        if (role == 'hr') const _ShiftPlanner(),
        if (role == 'owner') const _OwnerAttentionList(),
      ],
    );
  }
}

class _WorkerChecklist extends StatelessWidget {
  const _WorkerChecklist();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TaskTile(title: 'Clean machine area', subtitle: 'Daily checklist'),
        _TaskTile(title: 'Submit observation', subtitle: '+15 points'),
        _TaskTile(title: 'Shift handover', subtitle: 'Required before checkout'),
      ],
    );
  }
}

class _SupervisorTeamConfirm extends StatelessWidget {
  const _SupervisorTeamConfirm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TaskTile(title: 'VFL4001 · Ramesh', subtitle: 'Tap confirm or absent individually'),
        _TaskTile(title: 'VFL4002 · Suresh', subtitle: '3 second gap enforced'),
        _TaskTile(title: 'Log casual worker', subtitle: 'Name + ID entry'),
      ],
    );
  }
}

class _ManagerApprovals extends StatelessWidget {
  const _ManagerApprovals();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ApprovalTile(title: 'CL leave request', subtitle: 'VFL4001 · 1 day'),
        _ApprovalTile(title: 'Advance request', subtitle: 'VFL4005 · ₹5,000 · 3 months'),
      ],
    );
  }
}

class _ShiftPlanner extends StatelessWidget {
  const _ShiftPlanner();

  @override
  Widget build(BuildContext context) {
    const shifts = ['General', 'First', 'Second', 'Third', 'Day', 'Night'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Weekly Shift Planner', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            for (final shift in shifts)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule),
                title: Text(shift),
                subtitle: const Text('Assign employees and publish'),
                trailing: const Icon(Icons.chevron_right),
              ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.notifications_active_outlined),
              label: const Text('Publish schedule'),
            ),
          ],
        ),
      ),
    );
  }
}

class _OwnerAttentionList extends StatelessWidget {
  const _OwnerAttentionList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TaskTile(title: 'Forge Shop late trend', subtitle: 'Needs manager review'),
        _TaskTile(title: 'Maintenance observations low', subtitle: '3 workers flagged'),
        _TaskTile(title: 'Payroll variance', subtitle: 'HR preview required'),
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.task_alt),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Text('Open'),
      ),
    );
  }
}

class _ApprovalTile extends StatelessWidget {
  const _ApprovalTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(subtitle),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: FilledButton(onPressed: () {}, child: const Text('Approve'))),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
