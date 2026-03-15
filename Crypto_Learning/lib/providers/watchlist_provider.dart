import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';

final watchlistProvider = NotifierProvider<WatchlistNotifier, List<String>>(() {
  return WatchlistNotifier();
});

class WatchlistNotifier extends Notifier<List<String>> {
  static const _key = 'user_watchlist';

  @override
  List<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getStringList(_key) ??
        ['BTCUSDT', 'ETHUSDT', 'BNBUSDT', 'SOLUSDT', 'ADAUSDT'];
  }

  void toggleWatchlist(String symbol) {
    if (state.contains(symbol)) {
      removeFromWatchlist(symbol);
    } else {
      addToWatchlist(symbol);
    }
  }

  void addToWatchlist(String symbol) {
    if (!state.contains(symbol)) {
      state = [...state, symbol];
      _save();
    }
  }

  void removeFromWatchlist(String symbol) {
    state = state.where((s) => s != symbol).toList();
    _save();
  }

  void _save() {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setStringList(_key, state);
  }
}
