import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/market_provider.dart';
import '../../models/coin.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/alert_provider.dart';
import '../../providers/watchlist_provider.dart';
import '../../widgets/coin_icon.dart';

class CoinDetailScreen extends ConsumerWidget {
  final String symbol;
  const CoinDetailScreen({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topCoins = ref.watch(topCoinsProvider).value ?? [];
    final coin = topCoins.firstWhere(
      (c) => c.symbol == symbol,
      orElse: () => throw Exception('Coin not found'),
    );
    final watchlistSymbols = ref.watch(watchlistProvider);
    final isWatched = watchlistSymbols.contains(coin.symbol);

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.textPrimary),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          coin.baseAsset,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: context.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isWatched ? Icons.star : Icons.star_border,
              color: isWatched ? AppColors.warning : context.textPrimary,
            ),
            onPressed: () {
              ref.read(watchlistProvider.notifier).toggleWatchlist(coin.symbol);
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => _AddAlertBottomSheet(coin: coin),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Existing Price Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoinIcon(
                  symbol: coin.symbol,
                  size: 48,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    '\$${coin.currentPrice.toStringAsFixed(coin.currentPrice < 1 ? 4 : 2)}',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: context.textPrimary,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (coin.priceChangePercent24h >= 0
                                                ? AppColors.success
                                                : AppColors.danger)
                                            .withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '${coin.priceChangePercent24h >= 0 ? '+' : ''}${coin.priceChangePercent24h.toStringAsFixed(2)}%',
                                        style: TextStyle(
                                          color: coin.priceChangePercent24h >= 0
                                              ? AppColors.success
                                              : AppColors.danger,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Converter Section
            Text(
              '${coin.baseAsset} to USD converter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _ConverterWidget(coin: coin),
            const SizedBox(height: 32),

            // New Advanced Statistics Section
            Text(
              '${coin.baseAsset} statistics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _AdvancedStatsGrid(coin: coin),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ConverterWidget extends StatefulWidget {
  final CoinModel coin;
  const _ConverterWidget({required this.coin});

  @override
  State<_ConverterWidget> createState() => _ConverterWidgetState();
}

class _ConverterWidgetState extends State<_ConverterWidget> {
  late final TextEditingController _coinCtrl;
  late final TextEditingController _usdCtrl;

  @override
  void initState() {
    super.initState();
    _coinCtrl = TextEditingController(text: '1');
    _usdCtrl = TextEditingController(
      text: widget.coin.currentPrice.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _coinCtrl.dispose();
    _usdCtrl.dispose();
    super.dispose();
  }

  void _onCoinChanged(String value) {
    if (value.isEmpty) {
      _usdCtrl.text = '';
      return;
    }
    final coinAmount = double.tryParse(value);
    if (coinAmount != null) {
      final usdValue = coinAmount * widget.coin.currentPrice;
      _usdCtrl.text = usdValue.toStringAsFixed(2);
    }
  }

  void _onUsdChanged(String value) {
    if (value.isEmpty) {
      _coinCtrl.text = '';
      return;
    }
    final usdAmount = double.tryParse(value);
    if (usdAmount != null) {
      final coinValue = usdAmount / widget.coin.currentPrice;
      _coinCtrl.text = coinValue.toStringAsFixed(6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        border: Border.all(color: context.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _ConverterRow(
            label: widget.coin.baseAsset,
            controller: _coinCtrl,
            onChanged: _onCoinChanged,
            isTop: true,
          ),
          Divider(height: 1, color: context.borderColor),
          _ConverterRow(
            label: 'USD',
            controller: _usdCtrl,
            onChanged: _onUsdChanged,
            isTop: false,
          ),
        ],
      ),
    );
  }
}

class _ConverterRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool isTop;

  const _ConverterRow({
    required this.label,
    required this.controller,
    required this.onChanged,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: context.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvancedStatsGrid extends StatelessWidget {
  final CoinModel coin;
  const _AdvancedStatsGrid({required this.coin});

  String _formatNumber(double num) {
    if (num >= 1e12) return '${(num / 1e12).toStringAsFixed(2)}T';
    if (num >= 1e9) return '${(num / 1e9).toStringAsFixed(2)}B';
    if (num >= 1e6) return '${(num / 1e6).toStringAsFixed(2)}M';
    if (num >= 1e3) return '${(num / 1e3).toStringAsFixed(2)}K';
    return num.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final mcapStr = '\$${_formatNumber(coin.marketCap)}';
    final volStr = '\$${_formatNumber(coin.volume24h)}';
    final fdvStr = '\$${_formatNumber(coin.fdv)}';

    // Mock percentage change for volume (using price change * multiplier for demo)
    final volChange = coin.priceChangePercent24h * 15.1;
    final isVolChangePositive = volChange >= 0;

    return Column(
      children: [
        // Row 1: Market Cap (Full Width)
        _StatCard(
          label: 'Market cap',
          valueWidget: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            children: [
              Text(
                mcapStr,
                style: TextStyle(
                  color: context.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    coin.priceChangePercent24h >= 0
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: coin.priceChangePercent24h >= 0
                        ? AppColors.success
                        : AppColors.danger,
                    size: 20,
                  ),
                  Text(
                    '${coin.priceChangePercent24h.abs().toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: coin.priceChangePercent24h >= 0
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
        const SizedBox(height: 12),

        // Row 2: Volume & Vol/Mkt Cap (Half Width)
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Volume (24h)',
                valueWidget: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 2,
                  children: [
                    Text(
                      volStr,
                      style: TextStyle(
                        color: context.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isVolChangePositive
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: isVolChangePositive
                              ? AppColors.success
                              : AppColors.danger,
                          size: 16,
                        ),
                        Text(
                          '${volChange.abs().toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: isVolChangePositive
                                ? AppColors.success
                                : AppColors.danger,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey[600],
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Vol/Mkt Cap (24h)',
                value: '${coin.volMktCapRatio.toStringAsFixed(2)}%',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 3: FDV (Full Width)
        _StatCard(
          label: 'FDV',
          valueWidget: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 2,
            children: [
              Text(
                fdvStr,
                style: TextStyle(
                  color: context.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[600], size: 16),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Row 4: Supplies
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Total supply',
                value:
                    '${_formatNumber(coin.estimatedCirculatingSupply)} ${coin.baseAsset}',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Max. supply',
                value:
                    '${_formatNumber(coin.estimatedMaxSupply)} ${coin.baseAsset}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 5: Circulating & Treasury
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Circulating supply',
                labelTrailing: const Icon(
                  Icons.verified,
                  color: Colors.blueAccent,
                  size: 14,
                ),
                value:
                    '${_formatNumber(coin.estimatedCirculatingSupply)} ${coin.baseAsset}',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Treasury Holdings',
                value:
                    '${_formatNumber(coin.treasuryHoldings)} ${coin.baseAsset}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 6: Profile Score
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardColor,
            border: Border.all(color: context.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Profile score',
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.info_outline,
                    color: context.textSecondary,
                    size: 14,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '100%',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? valueWidget;
  final Widget? labelTrailing;

  const _StatCard({
    required this.label,
    this.value,
    this.valueWidget,
    this.labelTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: context.cardColor,
        border: Border.all(color: context.borderColor), // Subtle border
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: context.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.info_outline, color: Colors.grey[600], size: 14),
              if (labelTrailing != null) ...[
                const SizedBox(width: 4),
                labelTrailing!,
              ],
            ],
          ),
          const SizedBox(height: 10),
          if (valueWidget != null)
            valueWidget!
          else if (value != null)
            Text(
              value!,
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}

class _AddAlertBottomSheet extends ConsumerStatefulWidget {
  final CoinModel coin;
  const _AddAlertBottomSheet({required this.coin});

  @override
  ConsumerState<_AddAlertBottomSheet> createState() =>
      _AddAlertBottomSheetState();
}

class _AddAlertBottomSheetState extends ConsumerState<_AddAlertBottomSheet> {
  late final TextEditingController _priceCtrl;
  bool _isAbove = true;

  @override
  void initState() {
    super.initState();
    _priceCtrl = TextEditingController(
      text: widget.coin.currentPrice.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Create Price Alert',
            style: TextStyle(
              color: context.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Current ${widget.coin.baseAsset} Price: \$${widget.coin.currentPrice.toStringAsFixed(2)}',
            style: TextStyle(color: context.textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Alert me when price goes:',
            style: TextStyle(
              color: context.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isAbove = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: _isAbove
                          ? AppColors.success.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isAbove ? AppColors.success : Colors.grey[800]!,
                      ),
                    ),
                    child: Text(
                      'Above / At',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isAbove ? AppColors.success : Colors.grey[500],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isAbove = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: !_isAbove
                          ? AppColors.danger.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: !_isAbove ? AppColors.danger : Colors.grey[800]!,
                      ),
                    ),
                    child: Text(
                      'Below / At',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !_isAbove ? AppColors.danger : Colors.grey[500],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Target Price (USD)',
            style: TextStyle(
              color: context.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _priceCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(
              color: context.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: context.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                color: context.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(_priceCtrl.text);
              if (val != null && val > 0) {
                ref
                    .read(alertsProvider.notifier)
                    .addAlert(
                      symbol: widget.coin.symbol,
                      targetPrice: val,
                      isAbove: _isAbove,
                    );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Alert created for ${widget.coin.baseAsset} at \$${val.toStringAsFixed(2)}',
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Alert',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
