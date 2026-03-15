import 'package:dio/dio.dart';
import '../models/candle_data.dart';

class BinanceService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.binance.com/api/v3/klines';

  BinanceService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetches candlestick data from Binance API
  /// [symbol] e.g., 'BTCUSDT' (if 'BTC', 'USDT' will be appended)
  /// [interval] e.g., '1m', '5m', '15m', '1h', '4h', '1d'
  /// [limit] Default 1500, max 1000 for standard request, up to 1000 per request, 
  /// wait, binance limit max is 1000 per request. I will fetch 1000 to be safe
  /// Or if it needs 1500, we might need multiple requests, but let's stick to 1000 
  /// for a single request to avoid complex pagination unless required. The prompt 
  /// said: "limit=1500 for default load. Fetch between 1000 and 3000 candles".
  /// The prompt explicitly says Example request: ?symbol=BTCUSDT&interval=5m&limit=1500.
  /// Note: Binance standard limit is 1000, but some endpoints allow 1500 if weight permits, or might need a different endpoint. Let's use what the prompt asked.
  Future<List<CandleData>> fetchCandles({
    required String symbol,
    required String interval,
    int limit = 1500,
  }) async {
    try {
      final formattedSymbol = symbol.toUpperCase().endsWith('USDT')
          ? symbol.toUpperCase()
          : '${symbol.toUpperCase()}USDT';

      List<CandleData> allCandles = [];
      int remaining = limit;
      int? endTime;

      while (remaining > 0) {
        final currentLimit = remaining > 1000 ? 1000 : remaining;
        
        final Map<String, dynamic> queryParams = {
          'symbol': formattedSymbol,
          'interval': interval,
          'limit': currentLimit,
        };

        if (endTime != null) {
          queryParams['endTime'] = endTime;
        }

        final response = await _dio.get(
          _baseUrl,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = response.data;
          if (data.isEmpty) break;

          final candles = data.map((item) => CandleData.fromBinanceArray(item)).toList();
          
          // Prepend since earlier candles are fetched when providing endTime
          allCandles.insertAll(0, candles);

          // The oldest candle is the first item in the returned array
          endTime = candles.first.time.millisecondsSinceEpoch - 1;
          remaining -= data.length;
        } else {
          throw Exception('Failed to load chart data');
        }
      }

      return allCandles;
    } catch (e) {
      throw Exception('Error fetching candles: $e');
    }
  }
}
