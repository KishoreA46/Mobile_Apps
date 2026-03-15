import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../models/candle_data.dart';
import '../../services/binance_service.dart';
import '../../core/theme/app_colors.dart';

class CandlestickChart extends StatefulWidget {
  final String symbol;

  const CandlestickChart({
    super.key,
    required this.symbol,
  });

  @override
  State<CandlestickChart> createState() => _CandlestickChartState();
}

class _CandlestickChartState extends State<CandlestickChart> {
  final BinanceService _binanceService = BinanceService();

  final List<String> _timeframes = ['1m', '5m', '15m', '1h', '4h', '1d'];
  String _selectedTimeframe = '15m';

  // Cache to avoid refetching if already loaded
  final Map<String, List<CandleData>> _cachedData = {};

  bool _isLoading = true;
  String? _errorMessage;

  WebViewController? _controller;
  bool _webviewInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _webviewInitialized = true;
              });
              _loadChartData(_selectedTimeframe);
            }
          },
        ),
      );

    _controller?.loadHtmlString(_getHtmlTemplate());
  }

  Future<void> _loadChartData(String timeframe) async {
    if (!_webviewInitialized) return;

    setState(() {
      _selectedTimeframe = timeframe;
      _isLoading = true;
      _errorMessage = null;
    });

    List<CandleData> data;
    try {
      if (_cachedData.containsKey(timeframe)) {
        data = _cachedData[timeframe]!;
      } else {
        data = await _binanceService.fetchCandles(
          symbol: widget.symbol,
          interval: timeframe,
          limit: 1500,
        );
        _cachedData[timeframe] = data;
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _updateChartInWebView(data);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Chart data unavailable';
        });
      }
    }
  }

  void _updateChartInWebView(List<CandleData> data) {
    // Map data to TradingView JSON format
    // time scale for timeframe below 1D should be a Unix timestamp in seconds
    final formattedData = data.map((c) {
      return {
        'time': c.time.millisecondsSinceEpoch ~/ 1000,
        'open': c.open,
        'high': c.high,
        'low': c.low,
        'close': c.close,
      };
    }).toList();

    final jsonStr = jsonEncode(formattedData);
    
    // Call the javascript function defined in the HTML string
    _controller?.runJavaScript('updateChartData($jsonStr)');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTimeframeSelector(),
        const SizedBox(height: 16),
        SizedBox(
          height: 280, // Reduced height
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.borderColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _controller != null 
                      ? WebViewWidget(controller: _controller!) 
                      : const SizedBox.expand(),
                ),
              ),
              if (_isLoading)
                Container(
                  decoration: BoxDecoration(
                    color: context.cardColor.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (_errorMessage != null)
                Container(
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.borderColor),
                  ),
                  child: Center(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: AppColors.danger,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeframeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _timeframes.map((tf) {
          final isSelected = tf == _selectedTimeframe;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                if (!isSelected && !_isLoading && _webviewInitialized) {
                  _loadChartData(tf);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : context.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : context.borderColor,
                  ),
                ),
                child: Text(
                  tf,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : context.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getHtmlTemplate() {
    // Determine exact hex strings for themes avoiding Context calls inside HTML generation
    const String textStr = '#8F9BBA'; // Matching secondary text
    const String gridStr = '#1C212B'; // Matching border/grid lines
    
    // Success/Danger colors from AppColors
    const String bullStr = '#00C853'; 
    const String bearStr = '#F44336'; 

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: transparent;
      overflow: hidden;
    }
    #tvchart {
      width: 100vw;
      height: 100vh;
    }
  </style>
  <script src="https://unpkg.com/lightweight-charts/dist/lightweight-charts.standalone.production.js"></script>
</head>
<body>
  <div id="tvchart"></div>
  <script>
    let chart;
    let candlestickSeries;

    function initChart() {
      const container = document.getElementById('tvchart');
      
      chart = LightweightCharts.createChart(container, {
        layout: {
          background: { type: 'solid', color: 'transparent' },
          textColor: '$textStr',
        },
        grid: {
          vertLines: { color: '$gridStr' },
          horzLines: { color: '$gridStr' },
        },
        crosshair: {
          mode: LightweightCharts.CrosshairMode.Normal,
        },
        rightPriceScale: {
          borderColor: '$gridStr',
          autoScale: true,
        },
        timeScale: {
          borderColor: '$gridStr',
          timeVisible: true,
          secondsVisible: false,
        },
        handleScroll: {
          mouseWheel: true,
          pressedMouseMove: true,
          horzTouchDrag: true,
          vertTouchDrag: true,
        },
        handleScale: {
          axisPressedMouseMove: true,
          mouseWheel: true,
          pinch: true,
        },
      });

      candlestickSeries = chart.addCandlestickSeries({
        upColor: '$bullStr',
        downColor: '$bearStr',
        borderDownColor: '$bearStr',
        borderUpColor: '$bullStr',
        wickDownColor: '$bearStr',
        wickUpColor: '$bullStr',
      });

      window.addEventListener('resize', () => {
        chart.applyOptions({
          width: window.innerWidth,
          height: window.innerHeight,
        });
      });
    }

    function updateChartData(data) {
      if (!candlestickSeries) return;
      
      try {
        candlestickSeries.setData(data);
        // Optionally fit trailing data or all
        chart.timeScale().fitContent();
      } catch(e) {
        console.error(e);
      }
    }

    // Initialize chart on load
    initChart();
  </script>
</body>
</html>
''';
  }
}
