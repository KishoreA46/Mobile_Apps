import 'package:flutter/material.dart';
import '../../models/pattern.dart';
import '../../core/theme/app_colors.dart';

class PatternCard extends StatelessWidget {
  final PatternModel pattern;

  const PatternCard({super.key, required this.pattern});

  @override
  Widget build(BuildContext context) {
    final isBullish = pattern.type == 'Bullish';
    final isBearish = pattern.type == 'Bearish';

    Color typeColor = AppColors.textSecondary;
    if (isBullish) typeColor = AppColors.success;
    if (isBearish) typeColor = AppColors.danger;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pattern.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    pattern.type,
                    style: TextStyle(
                      color: typeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              pattern.description,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            // A placeholder for the actual candlestick image pattern
            const SizedBox(height: 16),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.surfaceHighlight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Text('Pattern Chart Image')),
            ),
          ],
        ),
      ),
    );
  }
}
