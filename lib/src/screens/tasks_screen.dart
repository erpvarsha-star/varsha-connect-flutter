import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';
import '../services/attendance_service.dart';
import '../services/firestore_paths.dart';
import '../services/firestore_service.dart';

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

class _SupervisorTeamConfirm extends StatefulWidget {
  const _SupervisorTeamConfirm();

  @override
  State<_SupervisorTeamConfirm> createState() => _SupervisorTeamConfirmState();
}

class _SupervisorTeamConfirmState extends State<_SupervisorTeamConfirm> {
  DateTime? lastTapAt;

  Future<void> _confirm(String empCode, bool present) async {
    final profile = context.read<AppState>().profile;
    if (profile == null) return;
    final now = DateTime.now();
    if (lastTapAt != null && now.difference(lastTapAt!).inSeconds < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wait 3 seconds between confirmations')),
      );
      return;
    }
    lastTapAt = now;
    await AttendanceService(firestoreService: FirestoreService()).saveSupervisorCheckpoint(
      empCode: empCode,
      shiftDate: DateFormat('yyyy-MM-dd').format(now),
      confirmedBy: profile.empCode,
      present: present,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$empCode marked ${present ? 'present' : 'absent'}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SupervisorTile(empCode: 'VFL4001', name: 'Ramesh', onConfirm: _confirm),
        _SupervisorTile(empCode: 'VFL4002', name: 'Suresh', onConfirm: _confirm),
        const _TaskTile(title: 'Log casual worker', subtitle: 'Name + ID entry'),
      ],
    );
  }
}

class _SupervisorTile extends StatelessWidget {
  const _SupervisorTile({required this.empCode, required this.name, required this.onConfirm});

  final String empCode;
  final String name;
  final Future<void> Function(String empCode, bool present) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('$empCode / $name', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: FilledButton(onPressed: () => onConfirm(empCode, true), child: const Text('Confirm'))),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton(onPressed: () => onConfirm(empCode, false), child: const Text('Absent'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagerApprovals extends StatelessWidget {
  const _ManagerApprovals();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ApprovalTile(
          title: 'CL leave request',
          subtitle: 'VFL4001 / 1 day',
          collection: FirestorePaths.leaveRequests,
          requestId: 'demo_leave_request',
        ),
        _ApprovalTile(
          title: 'Advance request',
          subtitle: 'VFL4005 / Rs 5,000 / 3 months',
          collection: FirestorePaths.advanceRequests,
          requestId: 'demo_advance_request',
        ),
      ],
    );
  }
}

class _ShiftPlanner extends StatelessWidget {
  const _ShiftPlanner();

  Future<void> _publish(BuildContext context) async {
    final profile = context.read<AppState>().profile;
    if (profile == null) return;
    await FirestoreService().saveShiftPlan({
      'week_start': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'department': profile.department,
      'published_by': profile.empCode,
      'status': 'published',
      'shift_types': ['general', 'first', 'second', 'third', 'day', 'night'],
    });
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Shift schedule published')),
    );
  }

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
              onPressed: () => _publish(context),
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
  const _ApprovalTile({
    required this.title,
    required this.subtitle,
    required this.collection,
    required this.requestId,
  });

  final String title;
  final String subtitle;
  final String collection;
  final String requestId;

  Future<void> _review(BuildContext context, String status) async {
    final profile = context.read<AppState>().profile;
    if (profile == null) return;
    await FirestoreService().reviewRequest(
      collection: collection,
      requestId: requestId,
      status: status,
      reviewedBy: profile.empCode,
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title $status')),
    );
  }

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
                Expanded(child: FilledButton(onPressed: () => _review(context, 'Approved'), child: const Text('Approve'))),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton(onPressed: () => _review(context, 'Rejected'), child: const Text('Reject'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
