import 'dart:convert';

class PriceAlert {
  final String id;
  final String symbol; // e.g., 'BTCUSDT'
  final double targetPrice;
  final bool
  isAbove; // true if alerted when price >= target, false if price <= target
  final bool isActive;

  PriceAlert({
    required this.id,
    required this.symbol,
    required this.targetPrice,
    required this.isAbove,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'targetPrice': targetPrice,
      'isAbove': isAbove,
      'isActive': isActive,
    };
  }

  factory PriceAlert.fromMap(Map<String, dynamic> map) {
    return PriceAlert(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      targetPrice: (map['targetPrice'] as num).toDouble(),
      isAbove: map['isAbove'] as bool,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceAlert.fromJson(String source) =>
      PriceAlert.fromMap(json.decode(source) as Map<String, dynamic>);

  PriceAlert copyWith({
    String? id,
    String? symbol,
    double? targetPrice,
    bool? isAbove,
    bool? isActive,
  }) {
    return PriceAlert(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      targetPrice: targetPrice ?? this.targetPrice,
      isAbove: isAbove ?? this.isAbove,
      isActive: isActive ?? this.isActive,
    );
  }
}
