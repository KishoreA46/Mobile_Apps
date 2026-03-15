import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/strategy.dart';
import '../../core/theme/app_colors.dart';

class StrategiesListScreen extends StatelessWidget {
  const StrategiesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = groupedStrategies;

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: const Text('Trading Strategies'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _StrategySection(
            title: 'Beginner Strategies',
            strategies: groups[StrategyLevel.beginner]!,
          ),
          _StrategySection(
            title: 'Intermediate Strategies',
            strategies: groups[StrategyLevel.intermediate]!,
          ),
          _StrategySection(
            title: 'Advanced Strategies',
            strategies: groups[StrategyLevel.advanced]!,
          ),
        ],
      ),
    );
  }
}

class _StrategySection extends StatelessWidget {
  final String title;
  final List<StrategyLesson> strategies;

  const _StrategySection({required this.title, required this.strategies});

  @override
  Widget build(BuildContext context) {
    if (strategies.isEmpty && !title.contains('Beginner')) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        if (strategies.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Coming soon...',
                style: TextStyle(color: context.textSecondary),
              ),
            ),
          )
        else
          ...strategies.map((s) => _StrategyCard(strategy: s)),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _StrategyCard extends StatelessWidget {
  final StrategyLesson strategy;

  const _StrategyCard({required this.strategy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/education/strategies/${strategy.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: strategy.level.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(strategy.icon, color: strategy.level.color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strategy.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    strategy.overview,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    strategy.level.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: strategy.level.color,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: context.textSecondary),
          ],
        ),
      ),
    );
  }
}
