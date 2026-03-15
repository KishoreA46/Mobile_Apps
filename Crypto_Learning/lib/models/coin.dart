class CoinModel {
  final String symbol;
  final double currentPrice;
  final double priceChangePercent24h;
  final double volume24h;
  final double high24h;
  final double low24h;

  CoinModel({
    required this.symbol,
    required this.currentPrice,
    required this.priceChangePercent24h,
    required this.volume24h,
    required this.high24h,
    required this.low24h,
  });

  factory CoinModel.fromBinance24h(Map<String, dynamic> json) {
    return CoinModel(
      symbol: json['symbol'] as String,
      currentPrice: double.tryParse(json['lastPrice'].toString()) ?? 0.0,
      priceChangePercent24h:
          double.tryParse(json['priceChangePercent'].toString()) ?? 0.0,
      volume24h: double.tryParse(json['volume'].toString()) ?? 0.0,
      high24h: double.tryParse(json['highPrice'].toString()) ?? 0.0,
      low24h: double.tryParse(json['lowPrice'].toString()) ?? 0.0,
    );
  }

  // To display the base asset (e.g. "BTC" from "BTCUSDT")
  String get baseAsset {
    if (symbol.endsWith('USDT')) {
      return symbol.substring(0, symbol.length - 4);
    }
    return symbol;
  }

  // --- Mock Data Helpers for Advanced Stats UI ---

  double get estimatedCirculatingSupply {
    // Mock realistic supply based on coin
    switch (baseAsset) {
      case 'BTC':
        return 19990000;
      case 'ETH':
        return 120000000;
      case 'SOL':
        return 460000000;
      case 'DOGE':
        return 145000000000;
      case 'XRP':
        return 56000000000;
      default:
        return volume24h * 10; // Fallback heuristic
    }
  }

  double get estimatedMaxSupply {
    switch (baseAsset) {
      case 'BTC':
        return 21000000;
      case 'SOL':
        return 580000000;
      case 'XRP':
        return 100000000000;
      case 'ADA':
        return 45000000000;
      default:
        return estimatedCirculatingSupply * 1.1; // Fallback
    }
  }

  double get marketCap => currentPrice * estimatedCirculatingSupply;
  double get fdv => currentPrice * estimatedMaxSupply;
  double get volMktCapRatio =>
      marketCap > 0 ? (volume24h / marketCap) * 100 : 0;
  double get treasuryHoldings => estimatedCirculatingSupply * 0.05; // 5% mock
}
