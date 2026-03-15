import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Using DateTime.now() instead of uuid to avoid dependencies

import '../models/price_alert.dart';
import '../providers/auth_provider.dart'; // Contains sharedPreferencesProvider

const _alertsKey = 'user_price_alerts';

class AlertsNotifier extends StateNotifier<List<PriceAlert>> {
  final SharedPreferences _prefs;

  AlertsNotifier(this._prefs) : super([]) {
    _loadAlerts();
  }

  void _loadAlerts() {
    final alertsJson = _prefs.getStringList(_alertsKey) ?? [];
    try {
      state = alertsJson
          .map((jsonStr) => PriceAlert.fromJson(jsonStr))
          .toList();
    } catch (e) {
      // print('Error parsing alerts: \$e');
      state = [];
    }
  }

  Future<void> _saveAlerts() async {
    final alertsJson = state.map((alert) => alert.toJson()).toList();
    await _prefs.setStringList(_alertsKey, alertsJson);
  }

  void addAlert({
    required String symbol,
    required double targetPrice,
    required bool isAbove,
  }) {
    final newAlert = PriceAlert(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      symbol: symbol,
      targetPrice: targetPrice,
      isAbove: isAbove,
    );
    state = [...state, newAlert];
    _saveAlerts();
  }

  void removeAlert(String id) {
    state = state.where((a) => a.id != id).toList();
    _saveAlerts();
  }

  void toggleAlertActive(String id) {
    state = state.map((a) {
      if (a.id == id) {
        return a.copyWith(isActive: !a.isActive);
      }
      return a;
    }).toList();
    _saveAlerts();
  }
}

final alertsProvider = StateNotifierProvider<AlertsNotifier, List<PriceAlert>>((
  ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AlertsNotifier(prefs);
});
