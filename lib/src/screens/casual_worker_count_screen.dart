import 'package:flutter/material.dart';

class CasualWorkerCountScreen extends StatefulWidget {
  const CasualWorkerCountScreen({super.key});

  @override
  State<CasualWorkerCountScreen> createState() => _CasualWorkerCountScreenState();
}

class _CasualWorkerCountScreenState extends State<CasualWorkerCountScreen> {
  int unskilled = 0;
  int skilled = 0;
  int operator = 0;

  void change(String type, int delta) {
    setState(() {
      if (type == 'unskilled') unskilled = (unskilled + delta).clamp(0, 999);
      if (type == 'skilled') skilled = (skilled + delta).clamp(0, 999);
      if (type == 'operator') operator = (operator + delta).clamp(0, 999);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Contract Labour', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        const Text('Department and shift will be filled from supervisor profile.'),
        const SizedBox(height: 16),
        _CounterRow(
          label: 'अकुशल / Unskilled',
          value: unskilled,
          onMinus: () => change('unskilled', -1),
          onPlus: () => change('unskilled', 1),
        ),
        const SizedBox(height: 12),
        _CounterRow(
          label: 'कुशल / Skilled',
          value: skilled,
          onMinus: () => change('skilled', -1),
          onPlus: () => change('skilled', 1),
        ),
        const SizedBox(height: 12),
        _CounterRow(
          label: 'ऑपरेटर / Operator',
          value: operator,
          onMinus: () => change('operator', -1),
          onPlus: () => change('operator', 1),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 56,
          child: FilledButton(
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}

class _CounterRow extends StatelessWidget {
  const _CounterRow({
    required this.label,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  final String label;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(child: Text(label, style: Theme.of(context).textTheme.titleMedium)),
            IconButton.filledTonal(onPressed: onMinus, icon: const Icon(Icons.remove)),
            SizedBox(
              width: 48,
              child: Center(child: Text('$value', style: Theme.of(context).textTheme.titleLarge)),
            ),
            IconButton.filled(onPressed: onPlus, icon: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
