import 'package:flutter/material.dart';
import '../../models/coin.dart';
import '../../core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'coin_icon.dart';

class CoinTile extends StatelessWidget {
  final CoinModel coin;
  final VoidCallback onTap;

  const CoinTile({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );
    final isPositive = coin.priceChangePercent24h >= 0;
    final changeColor = isPositive ? AppColors.success : AppColors.danger;
    final changeIcon = isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    // Fallback logo URL using coincap or binance generic if possible. For now a placeholder icon.
    final String symbolText = coin.baseAsset;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.surfaceHighlight)),
        ),
        child: Row(
          children: [
            // Logo placeholder
            CoinIcon(symbol: coin.symbol, size: 40),
            const SizedBox(width: 16),
            // Symbol & Vol
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    symbolText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vol ${(coin.volume24h / 1000000).toStringAsFixed(2)}M',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Price & Change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currencyFormat.format(coin.currentPrice),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(changeIcon, color: changeColor, size: 16),
                    Text(
                      '${coin.priceChangePercent24h.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: changeColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension NumberFormatExt on NumberFormat {
  String change(double val) {
    return '';
  }
}
