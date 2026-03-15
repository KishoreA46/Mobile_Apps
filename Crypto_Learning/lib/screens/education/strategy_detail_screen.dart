import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/strategy.dart';
import '../../core/theme/app_colors.dart';

class StrategyDetailScreen extends StatelessWidget {
  final StrategyLesson strategy;

  const StrategyDetailScreen({super.key, required this.strategy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: Text(strategy.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: strategy.level.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: strategy.level.color.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(strategy.icon, size: 40, color: strategy.level.color),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strategy.level.label,
                          style: TextStyle(
                            color: strategy.level.color,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          strategy.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildSection(context, 'Strategy Overview', strategy.overview),
            _buildListSection(context, 'Market Conditions', strategy.marketConditions),
            _buildListSection(context, 'Entry Rules', strategy.entryRules, isNumbered: true),
            _buildSection(context, 'Stop Loss', strategy.stopLoss, color: AppColors.danger),
            _buildSection(context, 'Take Profit', strategy.takeProfit, color: AppColors.success),
            _buildSection(context, 'Example Scenario', strategy.example),
            _buildListSection(context, 'Common Mistakes', strategy.commonMistakes, color: AppColors.warning),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: title),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.borderColor),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: color ?? context.textPrimary,
              fontWeight: color != null ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildListSection(BuildContext context, String title, List<String> items, {bool isNumbered = false, Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: title),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.asMap().entries.map((entry) {
              final idx = entry.key;
              final text = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isNumbered ? '${idx + 1}. ' : '• ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: color ?? context.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: context.textSecondary,
        letterSpacing: 1.5,
      ),
    );
  }
}
