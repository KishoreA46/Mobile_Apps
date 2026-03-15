import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../screens/main_navigation/main_navigation_screen.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/market/market_screen.dart';
import '../../screens/coin_detail/coin_detail_screen.dart';
import '../../screens/education/education_screen.dart';
import '../../screens/patterns/patterns_screen.dart';
import '../../screens/news/news_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/education/lesson_detail_screen.dart';
import '../../screens/education/strategies_list_screen.dart';
import '../../screens/education/strategy_detail_screen.dart';
import '../../models/lesson.dart';
import '../../models/strategy.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainNavigationScreen(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/market',
          builder: (context, state) => const MarketScreen(),
        ),
        GoRoute(
          path: '/education',
          builder: (context, state) => const EducationScreen(),
          routes: [
            GoRoute(
              path: 'lesson/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                final lesson = mockLessons.firstWhere((l) => l.id == id);
                return LessonDetailScreen(lesson: lesson);
              },
            ),
            GoRoute(
              path: 'strategies',
              builder: (context, state) => const StrategiesListScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    final strategy = mockStrategies.firstWhere((s) => s.id == id);
                    return StrategyDetailScreen(strategy: strategy);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/patterns',
          builder: (context, state) => const PatternsScreen(),
        ),
        GoRoute(
          path: '/news',
          builder: (context, state) => const NewsScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/coin/:symbol',
      builder: (context, state) =>
          CoinDetailScreen(symbol: state.pathParameters['symbol']!),
    ),
  ],
);
