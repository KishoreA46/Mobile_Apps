import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart'; // re-use the single sharedPreferencesProvider

// â”€â”€â”€ Theme Provider â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getString(_key) == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  void setDark() {
    state = ThemeMode.dark;
    ref.read(sharedPreferencesProvider).setString(_key, 'dark');
  }

  void setLight() {
    state = ThemeMode.light;
    ref.read(sharedPreferencesProvider).setString(_key, 'light');
  }

  void toggle() {
    if (state == ThemeMode.dark) {
      setLight();
    } else {
      setDark();
    }
  }

  bool get isDark => state == ThemeMode.dark;
}
