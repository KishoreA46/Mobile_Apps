import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/candle_data.dart';

// Provides the currently selected timeframe strings, default to '1h'
final chartTimeframeProvider = StateProvider<String>((ref) => '1h');

class ChartParams {
  final String symbol;
  final String interval;

  const ChartParams(this.symbol, this.interval);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChartParams &&
        other.symbol == symbol &&
        other.interval == interval;
  }

  @override
  int get hashCode => symbol.hashCode ^ interval.hashCode;
}

// Caches klines in memory using a Family provider keyed by (symbol, interval)
final chartDataProvider = FutureProvider.family<List<CandleData>, ChartParams>((
  ref,
  params,
) async {
  final url =
      'https://api.binance.com/api/v3/klines?symbol=${params.symbol.toUpperCase()}&interval=${params.interval}&limit=1000';

  final dio = Dio();
  final response = await dio.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = response.data;
    return jsonList
        .map((item) => CandleData.fromBinanceArray(item as List<dynamic>))
        .toList();
  } else {
    throw Exception(
      'Failed to load chart data for ${params.symbol} at ${params.interval}',
    );
  }
});
