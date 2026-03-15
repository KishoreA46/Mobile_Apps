import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../models/coin.dart';
import '../providers/chart_provider.dart';
import '../core/theme/app_colors.dart';

class CandlestickChartWidget extends ConsumerWidget {
  final CoinModel coin;
  const CandlestickChartWidget({super.key, required this.coin});

  DateTimeIntervalType _getIntervalType(String timeframe) {
    if (timeframe.endsWith('m')) return DateTimeIntervalType.minutes;
    if (timeframe.endsWith('h')) return DateTimeIntervalType.hours;
    if (timeframe.toLowerCase().endsWith('d')) return DateTimeIntervalType.days;
    return DateTimeIntervalType.auto;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeframe = ref.watch(chartTimeframeProvider);
    // Binance expects '1d' instead of '1D'
    final backendInterval = timeframe.toLowerCase();

    final chartDataAsync = ref.watch(
      chartDataProvider(ChartParams(coin.symbol, backendInterval)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeframe Selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['1m', '5m', '15m', '1h', '4h', '1D'].map((tf) {
              final isSelected = timeframe == tf;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(
                    tf,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(chartTimeframeProvider.notifier).state = tf;
                    }
                  },
                  backgroundColor: const Color(0xFF161922),
                  selectedColor: AppColors.primary.withValues(alpha: 0.2),
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.primary : Colors.grey[500],
                  ),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Chart container
        SizedBox(
          height: 380, // Increased height for readability
          child: chartDataAsync.when(
            data: (candles) {
              return SfCartesianChart(
                backgroundColor: Colors.transparent,
                plotAreaBorderWidth: 0,
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  enableDoubleTapZooming: true,
                  zoomMode: ZoomMode.x,
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  shared: true,
                  header: '',
                  canShowMarker: false,
                ),
                primaryXAxis: DateTimeAxis(
                  isVisible: true,
                  enableAutoIntervalOnZooming: true,
                  intervalType: _getIntervalType(timeframe),
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                  labelStyle: TextStyle(color: Colors.grey[600], fontSize: 10),
                ),
                primaryYAxis: NumericAxis(
                  isVisible: true,
                  opposedPosition: true,
                  majorGridLines: MajorGridLines(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  axisLine: const AxisLine(width: 0),
                  labelStyle: TextStyle(color: Colors.grey[600], fontSize: 10),
                  numberFormat: NumberFormat.simpleCurrency(
                    decimalDigits: coin.currentPrice < 1 ? 4 : 2,
                  ),
                ),
                series: <CartesianSeries>[
                  CandleSeries<dynamic, DateTime>(
                    dataSource: candles,
                    xValueMapper: (dynamic data, _) => data.time,
                    lowValueMapper: (dynamic data, _) => data.low,
                    highValueMapper: (dynamic data, _) => data.high,
                    openValueMapper: (dynamic data, _) => data.open,
                    closeValueMapper: (dynamic data, _) => data.close,
                    bearColor: AppColors.danger,
                    bullColor: AppColors.success,
                    enableSolidCandles: true,
                    name: coin.baseAsset,
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Text(
                'Chart not available',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
