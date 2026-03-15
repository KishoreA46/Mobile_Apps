import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

// Provider to hold SharedPreferences instance synchronously
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

// Provide the AuthService instance
final authServiceProvider = Provider<AuthService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthService(prefs);
});

// Provides the current user state
final authStateProvider = NotifierProvider<AuthNotifier, UserModel?>(() {
  return AuthNotifier();
});

class AuthNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    final authService = ref.watch(authServiceProvider);
    return authService.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    final authService = ref.read(authServiceProvider);
    final user = await authService.login(email, password);
    state = user;
  }

  Future<void> signup(String username, String email, String password) async {
    final authService = ref.read(authServiceProvider);
    final user = await authService.signup(username, email, password);
    state = user;
  }

  Future<void> logout() async {
    final authService = ref.read(authServiceProvider);
    await authService.logout();
    state = null;
  }
}
