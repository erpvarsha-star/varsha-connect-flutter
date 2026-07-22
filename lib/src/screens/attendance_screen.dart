import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';
import '../services/attendance_service.dart';
import '../services/firestore_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String status = 'Not marked today';
  bool checkedIn = false;
  bool saving = false;

  Future<void> _markArrival() async {
    final profile = context.read<AppState>().profile;
    if (profile == null) return;
    setState(() => saving = true);
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await AttendanceService(firestoreService: FirestoreService()).saveCheckpointOne(
      empCode: profile.empCode,
      department: profile.department,
      shiftDate: today,
      gpsValid: true,
      qrValid: false,
    );
    if (!mounted) return;
    setState(() {
      checkedIn = true;
      saving = false;
      status = 'Checkpoint 1 saved: GPS done, QR pending';
    });
  }

  Future<void> _checkout() async {
    final profile = context.read<AppState>().profile;
    if (profile == null) return;
    final controller = TextEditingController();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Maintenance observation'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Observation count',
            prefixIcon: Icon(Icons.build_outlined),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Submit')),
        ],
      ),
    );
    final observations = int.tryParse(controller.text.trim()) ?? 0;
    controller.dispose();
    if (submitted != true || !mounted) return;
    setState(() => saving = true);
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await FirestoreService().saveAttendance({
      'emp_code': profile.empCode,
      'department': profile.department,
      'date': today,
      'shift_id': 'general',
      'check_out_time': DateTime.now().toIso8601String(),
      'maintenance_observation_count': observations,
      'status': 'checkout_submitted',
    });
    if (!mounted) return;
    setState(() {
      checkedIn = false;
      saving = false;
      status = 'Checkout saved with $observations observations';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Attendance', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current shift', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('General Shift / 09:00 to 18:00'),
                const SizedBox(height: 8),
                const Text('Plant geofence: 19.8383935925407, 75.23638998304483 / 200m'),
                const SizedBox(height: 12),
                Text(status),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 96,
          child: FilledButton.icon(
            onPressed: checkedIn || saving ? null : _markArrival,
            icon: const Icon(Icons.my_location, size: 32),
            label: Text(saving ? 'Saving...' : 'I Have Arrived', textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC62828)),
            onPressed: checkedIn && !saving ? _checkout : null,
            icon: const Icon(Icons.logout, size: 32),
            label: const Text('I Am Done', textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(height: 16),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3-checkpoint flow', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('1. Worker GPS + QR'),
                Text('2. Security confirmation'),
                Text('3. Supervisor individual confirmation'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
