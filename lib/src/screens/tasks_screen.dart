import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Tasks', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        const Card(
          child: ListTile(
            leading: Icon(Icons.task_alt),
            title: Text('Submit shift handover report'),
            subtitle: Text('Due today'),
            trailing: Text('Assigned'),
          ),
        ),
      ],
    );
  }
}
