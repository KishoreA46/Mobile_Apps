import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coin.dart';
import '../services/api_service.dart';
import '../services/market_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final marketServiceProvider = Provider<MarketService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return MarketService(apiService);
});

// A provider that fetches the top coins once and caches them.
final topCoinsProvider = FutureProvider<List<CoinModel>>((ref) async {
  final marketService = ref.watch(marketServiceProvider);
  return marketService.getTopCoins();
});
