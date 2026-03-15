import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../core/constants/app_constants.dart';

class AuthService {
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<UserModel> login(String email, String password) async {
    // Mock authentication delay
    await Future.delayed(const Duration(seconds: 1));

    // Simple mock logic for demonstration
    if (email.isNotEmpty && password.length >= 6) {
      final username = email.split('@').first;

      // Persist session
      await _prefs.setBool(AppConstants.keyIsLoggedIn, true);
      await _prefs.setString(AppConstants.keyUsername, username);
      await _prefs.setString(AppConstants.keyUserEmail, email);

      return UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<UserModel> signup(
    String username,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      await _prefs.setBool(AppConstants.keyIsLoggedIn, true);
      await _prefs.setString(AppConstants.keyUsername, username);
      await _prefs.setString(AppConstants.keyUserEmail, email);

      return UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
      );
    } else {
      throw Exception('Invalid registration data');
    }
  }

  Future<void> logout() async {
    await _prefs.clear();
  }

  UserModel? getCurrentUser() {
    final isLoggedIn = _prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
    if (isLoggedIn) {
      final username = _prefs.getString(AppConstants.keyUsername) ?? 'User';
      final email = _prefs.getString(AppConstants.keyUserEmail) ?? '';
      return UserModel(id: '1', username: username, email: email);
    }
    return null;
  }
}
