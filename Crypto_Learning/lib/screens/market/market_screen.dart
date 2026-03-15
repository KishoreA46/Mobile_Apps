import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../providers/market_provider.dart';
import '../../providers/watchlist_provider.dart';
import '../../models/coin.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../main_navigation/main_navigation_screen.dart';
import '../../widgets/coin_icon.dart';

// Sort options
enum MarketSort {
  volumeHigh,
  volumeLow,
  alphabetAz,
  alphabetZa,
  gainers,
  losers,
}

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key});

  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  String _searchQuery = '';
  MarketSort _sort = MarketSort.volumeHigh;

  // Featured market leaders shown at the top
  static const _popularSymbols = AppConstants.marketLeaders;

  List<CoinModel> _applySort(List<CoinModel> coins) {
    final filtered = _searchQuery.isEmpty
        ? coins
        : coins
              .where(
                (c) =>
                    c.baseAsset.toLowerCase().contains(_searchQuery) ||
                    c.symbol.toLowerCase().contains(_searchQuery),
              )
              .toList();

    switch (_sort) {
      case MarketSort.volumeHigh:
        filtered.sort((a, b) => b.volume24h.compareTo(a.volume24h));
        break;
      case MarketSort.volumeLow:
        filtered.sort((a, b) => a.volume24h.compareTo(b.volume24h));
        break;
      case MarketSort.alphabetAz:
        filtered.sort((a, b) => a.baseAsset.compareTo(b.baseAsset));
        break;
      case MarketSort.alphabetZa:
        filtered.sort((a, b) => b.baseAsset.compareTo(a.baseAsset));
        break;
      case MarketSort.gainers:
        filtered.sort(
          (a, b) => b.priceChangePercent24h.compareTo(a.priceChangePercent24h),
        );
        break;
      case MarketSort.losers:
        filtered.sort(
          (a, b) => a.priceChangePercent24h.compareTo(b.priceChangePercent24h),
        );
        break;
    }
    return filtered;
  }

  // Build a list with popular coins first when showing default sort
  List<CoinModel> _buildSortedList(List<CoinModel> allCoins) {
    if (_searchQuery.isNotEmpty || _sort != MarketSort.volumeHigh) {
      return _applySort(allCoins);
    }
    // Put popular symbols first
    final popularSet = _popularSymbols.toSet();
    final popular = <CoinModel>[];
    final rest = <CoinModel>[];
    for (final coin in allCoins) {
      if (popularSet.contains(coin.symbol)) {
        popular.add(coin);
      } else {
        rest.add(coin);
      }
    }
    // Sort popular by our defined order
    popular.sort(
      (a, b) => (_popularSymbols.indexOf(
        a.symbol,
      )).compareTo(_popularSymbols.indexOf(b.symbol)),
    );
    rest.sort((a, b) => b.volume24h.compareTo(a.volume24h));
    return [...popular, ...rest];
  }

  @override
  Widget build(BuildContext context) {
    final topCoinsAsync = ref.watch(topCoinsProvider);

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: Text(
          'Market',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: context.textPrimary),
          onPressed: () => AppDrawerScope.of(
            context,
          )?.scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search coins...',
                prefixIcon: Icon(Icons.search, color: context.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: context.cardColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (val) =>
                  setState(() => _searchQuery = val.toLowerCase()),
            ),
          ),

          // Sort dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.borderColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<MarketSort>(
                  value: _sort,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: context.textSecondary),
                  dropdownColor: context.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  style: TextStyle(
                    color: context.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  items: const [
                    DropdownMenuItem(value: MarketSort.volumeHigh, child: Text('Volume: High to Low')),
                    DropdownMenuItem(value: MarketSort.volumeLow, child: Text('Volume: Low to High')),
                    DropdownMenuItem(value: MarketSort.alphabetAz, child: Text('Name: A to Z')),
                    DropdownMenuItem(value: MarketSort.alphabetZa, child: Text('Name: Z to A')),
                    DropdownMenuItem(value: MarketSort.gainers, child: Text('Top Gainers')),
                    DropdownMenuItem(value: MarketSort.losers, child: Text('Top Losers')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _sort = val);
                  },
                ),
              ),
            ),
          ),

          // Column headers
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'COIN',
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'PRICE',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    '24H',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.dividerColor),

          // Coin list
          Expanded(
            child: topCoinsAsync.when(
              data: (coins) {
                final sorted = _buildSortedList(coins);
                if (sorted.isEmpty) {
                  return const Center(
                    child: Text(
                      'No coins found',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: context.cardColor,
                  onRefresh: () => ref.refresh(topCoinsProvider.future),
                  child: ListView.separated(
                    separatorBuilder: (_, _) =>
                        Divider(height: 1, color: context.borderColor),
                    itemCount: sorted.length,
                    itemBuilder: (context, i) => _CoinRow(coin: sorted[i]),
                  ),
                );
              },
              loading: () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Loading market data...',
                    style: TextStyle(color: context.textSecondary),
                  ),
                ],
              ),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: context.textSecondary,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load market data',
                      style: TextStyle(color: context.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e.toString(),
                      style: const TextStyle(
                        color: AppColors.danger,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(topCoinsProvider.future),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinRow extends ConsumerWidget {
  final CoinModel coin;
  const _CoinRow({required this.coin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistSymbols = ref.watch(watchlistProvider);
    final isWatched = watchlistSymbols.contains(coin.symbol);
    final isPositive = coin.priceChangePercent24h >= 0;
    final priceFmt = coin.currentPrice > 1
        ? '\$${NumberFormat('#,##0.00').format(coin.currentPrice)}'
        : '\$${coin.currentPrice.toStringAsFixed(4)}';

    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.teal,
      Colors.red,
      Colors.cyan,
    ];
    final colorIndex = coin.baseAsset.codeUnitAt(0) % colors.length;

    return InkWell(
      onTap: () => context.push('/coin/${coin.symbol}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: context.textPrimary,
                ),
              ),
            ),
            Text(
              priceFmt,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isPositive ? AppColors.success : AppColors.danger)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${isPositive ? '+' : ''}${coin.priceChangePercent24h.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: isPositive ? AppColors.success : AppColors.danger,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
