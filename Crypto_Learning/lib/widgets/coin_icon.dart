import 'package:flutter/material.dart';

class CoinIcon extends StatelessWidget {
  final String symbol;
  final double size;

  const CoinIcon({
    super.key,
    required this.symbol,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    // Standardize symbol for filename (lowercase)
    String coinSymbol = symbol.toUpperCase();
    if (coinSymbol.endsWith('USDT')) {
      coinSymbol = coinSymbol.substring(0, coinSymbol.length - 4);
    }
    final String filename = coinSymbol.toLowerCase();

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/coins/$filename.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to circular avatar with first letter if asset missing
          return CircleAvatar(
            radius: size / 2,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(
              coinSymbol.isNotEmpty ? coinSymbol[0] : '?',
              style: TextStyle(
                fontSize: size * 0.5,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
