import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../providers/auth_provider.dart';
import '../../providers/market_provider.dart';
import '../../providers/watchlist_provider.dart';
import '../../screens/news/news_screen.dart';
import '../../providers/education_provider.dart';
import '../../models/lesson.dart';
import '../../models/coin.dart';
import '../../core/constants/app_constants.dart';
import '../../screens/main_navigation/main_navigation_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/coin_icon.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    final topCoins = ref.watch(topCoinsProvider);
    final watchlistSymbols = ref.watch(watchlistProvider);
    final newsAsync = ref.watch(newsProvider);

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: context.cardColor,
        onRefresh: () async {
          ref.invalidate(topCoinsProvider);
          ref.invalidate(newsProvider);
        },
        child: CustomScrollView(
          slivers: [
            // Hero App Bar
            SliverAppBar(
              expandedHeight: 160,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.menu, color: context.textPrimary),
                onPressed: () => AppDrawerScope.of(
                  context,
                )?.scaffoldKey.currentState?.openDrawer(),
              ),
              backgroundColor: context.bgColor,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: _HeroSection(username: user?.username ?? 'Trader'),
                stretchModes: const [StretchMode.fadeTitle],
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: context.textPrimary,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Quick Actions
                    _buildSectionHeader(context, 'Quick Actions', null),
                    const SizedBox(height: 12),
                    _buildQuickActions(context),
                    const SizedBox(height: 28),

                    // Learning Path
                    _buildSectionHeader(
                      context,
                      'Learning Path',
                      () => context.push('/education'),
                    ),
                    const SizedBox(height: 12),
                    _LearningPathCard(),
                    const SizedBox(height: 28),

                    // Live Watchlist
                    _buildSectionHeader(
                      context,
                      'Watchlist',
                      () => context.push('/market'),
                    ),
                    const SizedBox(height: 12),
                    topCoins.when(
                      data: (coins) {
                        final watchCoins = coins
                            .where((c) => watchlistSymbols.contains(c.symbol))
                            .toList();
                        return _WatchlistSection(coins: watchCoins);
                      },
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      error: (e, _) => const Text(
                        'Failed to load market data',
                        style: TextStyle(color: AppColors.danger),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Recent News Section
                    _buildSectionHeader(
                      context,
                      'Recent News',
                      () => context.push('/news'),
                    ),
                    const SizedBox(height: 12),
                    newsAsync.when(
                      data: (newsList) => Column(
                        children: newsList
                            .take(3)
                            .map((article) => _NewsCard(article: article))
                            .toList(),
                      ),
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      error: (e, _) => const Text(
                        'Failed to load news',
                        style: TextStyle(color: AppColors.danger),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback? onViewAll,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
        ),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: const Text(
              'View All',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final List<_QuickActionItem> items = [
      _QuickActionItem(
        Icons.analytics_outlined,
        'Market',
        const Color(0xFF3B82F6),
        () => context.push('/market'),
      ),
      _QuickActionItem(
        Icons.auto_stories_outlined,
        'Learn',
        const Color(0xFF10B981),
        () => context.push('/education'),
      ),
      _QuickActionItem(
        Icons.grid_view_rounded,
        'Patterns',
        const Color(0xFF8B5CF6),
        () => context.push('/patterns'),
      ),
      _QuickActionItem(
        Icons.newspaper_outlined,
        'News',
        const Color(0xFF14B8A6),
        () => context.push('/news'),
      ),
      _QuickActionItem(
        Icons.psychology_outlined,
        'Strategies',
        const Color(0xFFF59E0B),
        () => context.push('/education/strategies'),
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: items.map((item) => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _buildActionCard(context, item),
        )).toList(),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, _QuickActionItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: context.borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              item.icon,
              color: item.color,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            style: TextStyle(
              color: context.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickActionItem(this.icon, this.label, this.color, this.onTap);
}



class _LearningPathCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedCount = ref.watch(educationProvider).length;
    final totalCount = mockLessons.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;
    final progressPercent = (progress * 100).toInt();

    return GestureDetector(
      onTap: () => context.push('/education'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CONTINUE LEARNING',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Trading Academy',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: context.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: context.textSecondary.withValues(alpha: 0.5), size: 16),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: context.borderColor,
                      color: AppColors.primary,
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '$progressPercent%',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WatchlistSection extends StatelessWidget {
  final List coins;
  const _WatchlistSection({required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: coins.asMap().entries.map((entry) {
          final i = entry.key;
          final coin = entry.value;
          final isPositive = coin.priceChangePercent24h >= 0;
          return Column(
            children: [
              InkWell(
                onTap: () => context.push('/coin/${coin.symbol}'),
                borderRadius: i == 0 
                  ? const BorderRadius.vertical(top: Radius.circular(20))
                  : i == coins.length - 1
                    ? const BorderRadius.vertical(bottom: Radius.circular(20))
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      CoinIcon(
                        symbol: coin.symbol,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          coin.baseAsset,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: context.textPrimary,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            coin.currentPrice < 1
                                ? '\$${coin.currentPrice.toStringAsFixed(4)}'
                                : '\$${NumberFormat('#,##0.00').format(coin.currentPrice)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: context.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${isPositive ? '+' : ''}${coin.priceChangePercent24h.toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: isPositive
                                  ? AppColors.success
                                  : AppColors.danger,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (i < coins.length - 1)
                Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                  color: context.borderColor.withValues(alpha: 0.5),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}



class _NewsCard extends StatelessWidget {
  final dynamic article;
  const _NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(article.url);
        if (await canLaunchUrl(url)) launchUrl(url);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                height: 1.4,
                color: context.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.domain,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, HH:mm').format(article.publishedAt),
                  style: TextStyle(color: context.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _HeroSection extends ConsumerWidget {
  final String username;
  const _HeroSection({required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMM dd').format(now);

    return Container(
      width: double.infinity,
      color: context.bgColor,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${username.isNotEmpty ? username[0].toUpperCase() + username.substring(1) : 'Trader'}',
            style: TextStyle(
              color: context.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dateStr,
            style: TextStyle(
              color: context.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
