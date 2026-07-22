import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    phoneController.dispose();
    pinController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() => loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    context.read<AppState>().setProfile(
          StaffProfile(
            empCode: 'DEMO001',
            name: 'Demo Manager',
            role: 'manager',
            department: 'Forge Shop',
          ),
        );
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/varsha_logo.png',
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 18),
              Text('Varsha Connect', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Factory performance and accountability', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFF6B6B6B))),
              const SizedBox(height: 28),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone number'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'PIN'),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: loading ? null : login,
                child: Text(loading ? 'Checking...' : 'Login'),
              ),
              const SizedBox(height: 28),
              const Text(
                'VARSHA FORGINGS PVT LTD · AURANGABAD',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
