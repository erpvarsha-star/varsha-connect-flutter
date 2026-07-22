import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String status = 'Not marked today';
  bool checkedIn = false;

  void _markArrival() {
    setState(() {
      checkedIn = true;
      status = 'Checkpoint 1 ready: GPS + QR validation pending';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Plant geofence: 19.8383935925407, 75.23638998304483 · 200m')),
    );
  }

  Future<void> _checkout() async {
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
    controller.dispose();
    if (submitted != true || !mounted) return;
    setState(() {
      checkedIn = false;
      status = 'Checkout saved · observation submitted';
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
                const Text('General Shift · 09:00 to 18:00'),
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
            onPressed: checkedIn ? null : _markArrival,
            icon: const Icon(Icons.my_location, size: 32),
            label: const Text('मैं पहुँच गया\nI Have Arrived', textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC62828)),
            onPressed: checkedIn ? _checkout : null,
            icon: const Icon(Icons.logout, size: 32),
            label: const Text('मैंने काम पूरा किया\nI Am Done', textAlign: TextAlign.center),
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
