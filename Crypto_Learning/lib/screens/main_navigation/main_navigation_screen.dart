import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/auth_provider.dart';

class AppDrawerScope extends InheritedWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppDrawerScope({
    super.key,
    required this.scaffoldKey,
    required super.child,
  });

  static AppDrawerScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDrawerScope>();
  }

  @override
  bool updateShouldNotify(AppDrawerScope oldWidget) =>
      scaffoldKey != oldWidget.scaffoldKey;
}

class MainNavigationScreen extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainNavigationScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppDrawerScope(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        body: child,
      ),
    );
  }
}

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);

    return Drawer(
      backgroundColor: context.bgColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: context.cardColor),
            accountName: Text(
              user?.username ?? 'Guest',
              style: TextStyle(
                color: context.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user?.email ?? 'guest@example.com',
              style: TextStyle(color: context.textSecondary),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                user?.username.substring(0, 1).toUpperCase() ?? 'G',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              context.go('/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Market'),
            onTap: () {
              Navigator.pop(context);
              context.push('/market');
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Education'),
            onTap: () {
              Navigator.pop(context);
              context.push('/education');
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Patterns'),
            onTap: () {
              Navigator.pop(context);
              context.push('/patterns');
            },
          ),
          ListTile(
            leading: const Icon(Icons.psychology_outlined),
            title: const Text('Strategies'),
            onTap: () {
              Navigator.pop(context);
              context.push('/education/strategies');
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('News'),
            onTap: () {
              Navigator.pop(context);
              context.push('/news');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              context.push('/profile');
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              context.push('/settings');
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
