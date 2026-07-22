import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/attendance_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/forms_screen.dart';
import 'screens/login_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/performance_screen.dart';
import 'screens/tasks_screen.dart';
import 'theme.dart';

class VarshaConnectApp extends StatelessWidget {
  const VarshaConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        ShellRoute(
          builder: (_, __, child) => AppShell(child: child),
          routes: [
            GoRoute(path: '/', builder: (_, __) => const DashboardScreen()),
            GoRoute(path: '/attendance', builder: (_, __) => const AttendanceScreen()),
            GoRoute(path: '/forms', builder: (_, __) => const FormsScreen()),
            GoRoute(path: '/tasks', builder: (_, __) => const TasksScreen()),
            GoRoute(path: '/performance', builder: (_, __) => const PerformanceScreen()),
            GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Varsha Connect',
      theme: buildVarshaTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    final index = switch (path) {
      '/attendance' => 1,
      '/forms' => 2,
      '/tasks' => 3,
      '/performance' => 4,
      '/notifications' => 5,
      _ => 0,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF6B6B6B),
        elevation: 0,
        titleSpacing: 12,
        title: Row(
          children: [
            Image.asset('assets/images/varsha_logo.png', height: 28, width: 28, fit: BoxFit.contain),
            const SizedBox(width: 8),
            const Text('Varsha Forgings', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 16)),
          ],
        ),
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE87722).withValues(alpha: 0.12),
        selectedIndex: index,
        onDestinationSelected: (value) {
          final route = switch (value) {
            1 => '/attendance',
            2 => '/forms',
            3 => '/tasks',
            4 => '/performance',
            5 => '/notifications',
            _ => '/',
          };
          context.go(route);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.pin_drop_outlined), selectedIcon: Icon(Icons.pin_drop), label: 'Attendance'),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: 'Forms'),
          NavigationDestination(icon: Icon(Icons.task_alt_outlined), selectedIcon: Icon(Icons.task_alt), label: 'Tasks'),
          NavigationDestination(icon: Icon(Icons.score_outlined), selectedIcon: Icon(Icons.score), label: 'Score'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined), selectedIcon: Icon(Icons.notifications), label: 'Alerts'),
        ],
      ),
    );
  }
}
