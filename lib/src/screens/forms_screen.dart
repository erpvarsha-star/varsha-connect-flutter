import 'package:flutter/material.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  static const forms = [
    'N1 Forge Shop hourly production log',
    'N2 Press Shop hourly production log',
    'N3 Heat Treatment batch log',
    'N4 Maintenance daily PM checklist',
    'N5 Electricity daily consumption log',
    'N6 Shift report',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: forms.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text('Daily Forms', style: Theme.of(context).textTheme.headlineSmall);
        }
        final form = forms[index - 1];
        return Card(
          child: ListTile(
            title: Text(form),
            subtitle: const Text('Due by shift end'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}
