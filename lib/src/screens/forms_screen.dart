import 'package:flutter/material.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Forms', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        _ActionCard(
          title: 'Leave Balance',
          subtitle: 'EL 0 · CL 0 · SL 0',
          button: 'छुट्टी के लिए आवेदन / Apply for Leave',
          onTap: () => _showLeaveForm(context),
        ),
        const SizedBox(height: 12),
        _ActionCard(
          title: 'Salary Advance',
          subtitle: 'बकाया अग्रिम / Outstanding Advance: ₹0',
          button: 'अग्रिम के लिए आवेदन / Apply for Advance',
          onTap: () => _showAdvanceForm(context),
        ),
        const SizedBox(height: 12),
        const _DailyFormsCard(),
      ],
    );
  }

  void _showLeaveForm(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _LeaveForm(),
    );
  }

  void _showAdvanceForm(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _AdvanceForm(),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.button,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String button;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(subtitle),
            const SizedBox(height: 14),
            FilledButton(onPressed: onTap, child: Text(button, textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}

class _LeaveForm extends StatefulWidget {
  const _LeaveForm();

  @override
  State<_LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<_LeaveForm> {
  String leaveType = 'CL';

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Apply for Leave',
      children: [
        DropdownButtonFormField<String>(
          initialValue: leaveType,
          decoration: const InputDecoration(labelText: 'Leave Type'),
          items: const ['EL', 'CL', 'SL'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
          onChanged: (value) => setState(() => leaveType = value ?? 'CL'),
        ),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(labelText: 'From Date')),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(labelText: 'To Date')),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(labelText: 'Reason optional')),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('आवेदन भेज दिया गया / Application Submitted')),
            );
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class _AdvanceForm extends StatelessWidget {
  const _AdvanceForm();

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Apply for Advance',
      children: [
        const TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Amount Requested'),
        ),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(labelText: 'Reason')),
        const SizedBox(height: 12),
        DropdownButtonFormField<int>(
          initialValue: 1,
          decoration: const InputDecoration(labelText: 'Repayment Period'),
          items: const [
            DropdownMenuItem(value: 1, child: Text('1 month')),
            DropdownMenuItem(value: 2, child: Text('2 months')),
            DropdownMenuItem(value: 3, child: Text('3 months')),
            DropdownMenuItem(value: 6, child: Text('6 months')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('आवेदन भेज दिया गया / Application Submitted')),
            );
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DailyFormsCard extends StatelessWidget {
  const _DailyFormsCard();

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Google Sheet Forms', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final form in forms)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.assignment_outlined),
                title: Text(form),
                subtitle: const Text('Due by shift end'),
              ),
          ],
        ),
      ),
    );
  }
}
