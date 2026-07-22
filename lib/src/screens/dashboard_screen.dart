import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';
import '../widgets/status_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    final role = profile?.role ?? 'worker';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _RoleSwitcher(activeRole: role),
        const SizedBox(height: 14),
        Text(_titleFor(role), style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text('${profile?.name ?? 'Staff'} · ${profile?.department ?? ''}'),
        const SizedBox(height: 16),
        ...switch (role) {
          'supervisor' => _supervisorCards(),
          'manager' => _managerCards(),
          'hr' => _hrCards(),
          'owner' => _ownerCards(),
          _ => _workerCards(),
        },
      ],
    );
  }

  String _titleFor(String role) {
    return switch (role) {
      'supervisor' => 'Supervisor Home',
      'manager' => 'Manager Home',
      'hr' => 'HR Admin Home',
      'owner' => 'Owner Dashboard',
      _ => 'Worker Home',
    };
  }

  List<Widget> _workerCards() => const [
        StatusCard(title: 'Today', value: 'Not checked in', icon: Icons.pin_drop_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Leave', value: 'EL 0 · CL 0 · SL 0', icon: Icons.event_available_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Advance', value: 'Outstanding ₹0', icon: Icons.currency_rupee),
        SizedBox(height: 10),
        StatusCard(title: 'Score', value: 'Attendance + Performance + Observations', icon: Icons.score_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'EoTM', value: 'Rank will show after scoring', icon: Icons.emoji_events_outlined),
      ];

  List<Widget> _supervisorCards() => const [
        StatusCard(title: 'Team live list', value: 'Present 18 · Late 2 · Absent 3', icon: Icons.groups_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Casual workers', value: 'Log name and ID', icon: Icons.badge_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Shift report', value: 'Due 2 hours before shift end', icon: Icons.fact_check_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'My score', value: 'View attendance and performance', icon: Icons.score_outlined),
      ];

  List<Widget> _managerCards() => const [
        StatusCard(title: 'Department attendance', value: 'Live overview by team', icon: Icons.analytics_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'KPI / KRA', value: 'Review performance inputs', icon: Icons.trending_up),
        SizedBox(height: 10),
        StatusCard(title: 'Approvals', value: 'Leave and advance pending', icon: Icons.approval_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'EoTM', value: 'Nominate and review', icon: Icons.emoji_events_outlined),
      ];

  List<Widget> _hrCards() => const [
        StatusCard(title: 'Shift planner', value: 'Weekly grid and publish', icon: Icons.calendar_month_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Attendance master', value: 'Manual override enabled', icon: Icons.edit_calendar_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Payroll preview', value: 'Per employee cost view', icon: Icons.payments_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Sheets export', value: 'Reporting mirror ready', icon: Icons.table_chart_outlined),
      ];

  List<Widget> _ownerCards() => const [
        StatusCard(title: 'Workforce cost', value: 'This month summary', icon: Icons.currency_rupee),
        SizedBox(height: 10),
        StatusCard(title: 'Attendance health', value: 'Present, late, absent trend', icon: Icons.monitor_heart_outlined),
        SizedBox(height: 10),
        StatusCard(title: 'Satisfaction', value: 'Worker signal score', icon: Icons.sentiment_satisfied_alt),
        SizedBox(height: 10),
        StatusCard(title: 'Needs attention', value: 'People and departments flagged', icon: Icons.priority_high),
      ];
}

class _RoleSwitcher extends StatelessWidget {
  const _RoleSwitcher({required this.activeRole});

  final String activeRole;

  @override
  Widget build(BuildContext context) {
    const roles = {
      'worker': 'Worker',
      'supervisor': 'Supervisor',
      'manager': 'Manager',
      'hr': 'HR',
      'owner': 'Owner',
    };
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<String>(
        segments: [
          for (final entry in roles.entries)
            ButtonSegment(value: entry.key, label: Text(entry.value)),
        ],
        selected: {activeRole},
        onSelectionChanged: (selected) {
          context.read<AppState>().switchRole(selected.first);
        },
      ),
    );
  }
}
