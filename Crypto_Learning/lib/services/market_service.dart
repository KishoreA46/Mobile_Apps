import '../models/coin.dart';
import '../core/constants/app_constants.dart';
import 'api_service.dart';

class MarketService {
  final ApiService _apiService;

  MarketService(this._apiService);

  Future<List<CoinModel>> getTopCoins() async {
    try {
      final response = await _apiService.get('/ticker/24hr');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        // Filter only the featured symbols from AppConstants
        final featuredSet = AppConstants.featuredSymbols.toSet();
        var usdtPairs = data
            .where((json) => featuredSet.contains(json['symbol'].toString()))
            .map(
              (json) => CoinModel.fromBinance24h(json as Map<String, dynamic>),
            )
            .toList();

        usdtPairs.sort((a, b) => b.volume24h.compareTo(a.volume24h));

        return usdtPairs;
      } else {
        throw Exception('Failed to load market data');
      }
    } catch (e) {
      throw Exception('Error fetching market data: $e');
    }
  }

  // Fetch candlestick (kline) data with pagination support
  Future<List<Map<String, dynamic>>> getKlines(
    String symbol,
    String interval, {
    int limit = 500,
    int? endTime,
  }) async {
    try {
      List<Map<String, dynamic>> allKlines = [];
      int remaining = limit;
      int? currentEndTime = endTime;

      // Binance allows max 1000 per request.
      while (remaining > 0) {
        final currentLimit = remaining > 1000 ? 1000 : remaining;

        final Map<String, dynamic> queryParams = {
          'symbol': symbol,
          'interval': interval,
          'limit': currentLimit,
        };

        if (currentEndTime != null) {
          queryParams['endTime'] = currentEndTime;
        }

        final response = await _apiService.get(
          '/klines',
          queryParameters: queryParams,
        );

        if (response.statusCode == 200) {
          final List batch = response.data as List;
          if (batch.isEmpty) break;

          final List<Map<String, dynamic>> batchData = batch
              .map(
                (k) => {
                  'time': k[0] as int,
                  'open': double.parse(k[1]),
                  'high': double.parse(k[2]),
                  'low': double.parse(k[3]),
                  'close': double.parse(k[4]),
                  'volume': double.parse(k[5]),
                },
              )
              .toList();

          // Binance returns oldest first in the batch.
          // When paginating backwards, this batch is older than the previous one.
          allKlines.insertAll(0, batchData);

          remaining -= batchData.length;
          // Set endTime for next batch to 1ms before the oldest candle in the current batch
          currentEndTime = batchData.first['time'] - 1;

          // Safety break if we get fewer than requested (end of data)
          if (batchData.length < currentLimit) break;
        } else {
          throw Exception('Failed to load kline data');
        }
      }

      // Ensure chronological order
      allKlines.sort((a, b) => (a['time'] as int).compareTo(b['time'] as int));
      return allKlines;
    } catch (e) {
      throw Exception('Error fetching kline data: $e');
    }
  }
}
