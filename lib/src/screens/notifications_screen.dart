import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Notifications', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        const _AlertTile(
          title: '30 min before shift',
          subtitle: 'Open app and check in',
          icon: Icons.alarm,
        ),
        const _AlertTile(
          title: '15 min after shift start',
          subtitle: 'क्या आज छुट्टी है? YES / NO',
          icon: Icons.help_outline,
        ),
        const _AlertTile(
          title: '2 hours before shift end',
          subtitle: 'Supervisor shift report reminder',
          icon: Icons.fact_check_outlined,
        ),
        const _AlertTile(
          title: 'Shift end',
          subtitle: 'Shift खत्म — checkout करें',
          icon: Icons.logout,
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: null,
          icon: const Icon(Icons.volume_up_outlined),
          label: const Text('Push notification + sound enabled after Firebase Messaging setup'),
        ),
      ],
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFE87722)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
