import 'package:flutter/material.dart';

enum StrategyLevel {
  beginner,
  intermediate,
  advanced;

  String get label {
    switch (this) {
      case StrategyLevel.beginner:
        return 'Beginner';
      case StrategyLevel.intermediate:
        return 'Intermediate';
      case StrategyLevel.advanced:
        return 'Advanced';
    }
  }

  Color get color {
    switch (this) {
      case StrategyLevel.beginner:
        return Colors.green;
      case StrategyLevel.intermediate:
        return Colors.orange;
      case StrategyLevel.advanced:
        return Colors.deepPurpleAccent;
    }
  }
}

class StrategyLesson {
  final String id;
  final String title;
  final StrategyLevel level;
  final String overview;
  final List<String> marketConditions;
  final List<String> entryRules;
  final String stopLoss;
  final String takeProfit;
  final String example;
  final List<String> commonMistakes;
  final String practiceTask;
  final IconData icon;

  const StrategyLesson({
    required this.id,
    required this.title,
    required this.level,
    required this.overview,
    required this.marketConditions,
    required this.entryRules,
    required this.stopLoss,
    required this.takeProfit,
    required this.example,
    required this.commonMistakes,
    required this.practiceTask,
    this.icon = Icons.trending_up,
  });
}

const List<StrategyLesson> mockStrategies = [
  // BEGINNER STRATEGIES (7)
  StrategyLesson(
    id: 'b1',
    title: 'Support Bounce Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.south_east,
    overview: 'Support is a price level where buying pressure historically overcomes selling pressure, causing price to "bounce" upward. In crypto, support levels form when a coin repeatedly stops falling at the same price zone — for example, Bitcoin holding \$60,000 multiple times.',
    marketConditions: [
      'Uptrend with higher lows',
      'Defensive buying at key levels'
    ],
    entryRules: [
      'Wait for price to pull back to a known support level.',
      'Identify a bullish confirmation candle (Hammer, Bullish Engulfing, or Pin Bar).',
      'Enter long (buy) position.'
    ],
    stopLoss: 'Placed just below the support zone.',
    takeProfit: 'Target is the next resistance level above.',
    example: r'Bitcoin hits $60,000 for the fourth time and forms a hammer candle. You buy at $60,200.',
    commonMistakes: [
      'Buying just because price touched support without confirmation.',
      'Ignoring that support can and does break.',
    ],
    practiceTask: 'Find a coin currently at support and wait for a confirmation candle before "buying" in demo.',
  ),
  StrategyLesson(
    id: 'b2',
    title: 'Resistance Rejection Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.north_east,
    overview: 'Resistance is a price level where selling pressure historically overcomes buying pressure, causing price to reverse downward. In crypto, resistance zones form when a coin repeatedly fails to close above the same price area — for example, Ethereum repeatedly rejecting at \$4,000.',
    marketConditions: [
      'Downtrend or sideways market',
      'High volume rejection at levels'
    ],
    entryRules: [
      'Wait for price to rally into a known resistance zone.',
      'Look for a bearish confirmation candle (Shooting Star, Bearish Engulfing, or Bearish Pin Bar).',
      'Enter short (sell) position.'
    ],
    stopLoss: 'Placed just above the resistance zone.',
    takeProfit: 'Target is the next support level below.',
    example: r'Ethereum reaches $4,000 and fails to break higher. You short at $3,950.',
    commonMistakes: [
      'Shorting into a strong breakout.',
      'Ignoring volume confirmation (rejection on high volume is stronger).',
    ],
    practiceTask: 'Identify a resistance zone on the ETH chart and look for a Shooting Star pattern.',
  ),
  StrategyLesson(
    id: 'b3',
    title: 'Breakout Trading Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.bolt,
    overview: 'A breakout occurs when price moves decisively beyond a key support or resistance level with increased momentum. In crypto, breakouts are powerful because the market runs 24/7 and can gap through levels during off-hours.',
    marketConditions: [
      'Post-consolidation momentum',
      'Rising volume'
    ],
    entryRules: [
      'Identify a consolidation zone, trendline, or horizontal level.',
      'Wait for price to close a candle above (bullish) or below (bearish) the level.',
      'Enter on the candle close or a retest of the broken level.'
    ],
    stopLoss: 'Sits just inside the broken level.',
    takeProfit: 'Height of the prior consolidation range projected from the breakout point.',
    example: r'BTC breaks above $65,000 with high volume. You buy at $65,100.',
    commonMistakes: [
      'Falling for a "fakeout" (false breakout).',
      'Trading without volume confirmation.',
    ],
    practiceTask: 'Find a tight consolidation and wait for a candle to close outside it.',
  ),
  StrategyLesson(
    id: 'b4',
    title: 'Pullback Trading Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.u_turn_left,
    overview: 'A pullback is a temporary price retracement against the prevailing trend before continuation in the original direction. In crypto, pullbacks are healthy and normal — even the strongest rallies pause to retrace.',
    marketConditions: [
      'Strong prevailing trend',
      'Normal retracement phases'
    ],
    entryRules: [
      'Identify a strong trending market.',
      'Wait for price to pull back to a key level (MA, trendline, or prior R-turned-S).',
      'Enter when a bullish confirmation candle signals the trend is resuming.'
    ],
    stopLoss: 'Placed below the pullback low.',
    takeProfit: 'Prior swing high or a projected extension.',
    example: r'SOL grows to $120, dips to $110, and bounces. You buy at $112.',
    commonMistakes: [
      'Buying a pullback that has turned into a trend reversal.',
      'Chasing the move instead of waiting for a favorable risk-reward entry.',
    ],
    practiceTask: 'Scan for coins that just broke out and are now returning to the breakout level.',
  ),
  StrategyLesson(
    id: 'b5',
    title: 'Trendline Bounce Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.trending_up,
    overview: 'A trendline is a diagonal line drawn connecting a series of higher lows (uptrend) or lower highs (downtrend). In crypto, trendlines act as dynamic support and resistance.',
    marketConditions: [
      'Clear diagonal trend',
      'At least two confirmed touch points'
    ],
    entryRules: [
      'Draw a valid trendline with at least two touches.',
      'Wait for price to pull back to that trendline a third time.',
      'Enter on a confirmation candle touch/bounce.'
    ],
    stopLoss: 'Placed just beyond the trendline.',
    takeProfit: 'Prior swing high or low.',
    example: r'Price touches a diagonal support for the 3rd time at $80. You buy.',
    commonMistakes: [
      'Forcing trendlines that don’t connect naturally.',
      'Ignoring that the more times a line is hit, the more likely it is to break.',
    ],
    practiceTask: 'Draw an ascending trendline on a coin and set an alert for the next touch.',
  ),
  StrategyLesson(
    id: 'b6',
    title: 'Range Trading Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.unfold_more,
    overview: 'A range market oscillates between a defined support (low) and resistance (high). In crypto, ranges often form during periods of consolidation after major moves.',
    marketConditions: [
      'Sideways price action',
      'Lack of a clear trend'
    ],
    entryRules: [
      'Buy near the bottom of the range (support).',
      'Sell or short near the top of the range (resistance).',
      'Use tight stops as a breakout could happen at any time.'
    ],
    stopLoss: 'Just outside the range boundaries.',
    takeProfit: 'Target near the opposite side of the range.',
    example: r'BTC bounces between $60k and $70k. You buy at $61k.',
    commonMistakes: [
      'Trading too close to a major news event.',
      'Missing the volume spike that often precedes a break.',
    ],
    practiceTask: 'Find a coin that has been sideways for 5+ days and mark its range.',
  ),
  StrategyLesson(
    id: 'b7',
    title: 'Candlestick Confirmation Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.grid_view,
    overview: 'The Candlestick Confirmation Strategy combines candlestick reversal signals with a key level — support, resistance, trendline, or moving average — to create high-probability setups.',
    marketConditions: [
      'Price at a predefined level of interest',
      'Clear reversal patterns'
    ],
    entryRules: [
      'Wait for price to reach a key level.',
      'Watch for a confirming pattern (Bullish Engulfing at support, Shooting Star at resistance).',
      'Enter on the close of the confirmation candle.'
    ],
    stopLoss: 'Placed beyond the wick of the pattern candle.',
    takeProfit: 'Next significant level of interest.',
    example: r'A Bullish Engulfing forms exactly at the $50 support level.',
    commonMistakes: [
      'Trading patterns in isolation without a key level.',
      'Ignoring the "golden rule": Pattern is the trigger, level is the reason.',
    ],
    practiceTask: 'Find three examples on the 4H chart where a pattern occurred at a major horizontal level.',
  ),
  StrategyLesson(
    id: 'b8',
    title: 'Swing Trading Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.unfold_more,
    overview: 'Swing trading aims to capture medium-term price moves, typically holding trades for several days to a few weeks. In crypto, swing traders use the Daily and 4-Hour charts to identify trending markets and reversal setups.',
    marketConditions: [
      'Trending markets',
      'Medium-term price swings'
    ],
    entryRules: [
      'Identify the dominant trend on Daily/4H charts.',
      'Enter near the beginning of a swing move (support/reversal).',
      'Exit near its peak before the next pullback.'
    ],
    stopLoss: 'Wider than scalping to accommodate normal fluctuations.',
    takeProfit: 'Near the peak of the swing or key resistance.',
    example: r'You buy BTC at $60k and hold for 10 days as it "swings" to $70k.',
    commonMistakes: [
      'Monitoring screens too constantly and exiting early due to noise.',
      'Failing to adjust position size for wider stops.',
    ],
    practiceTask: 'Identify a coin in a clear 4H uptrend and mark the swing lows.',
  ),
  StrategyLesson(
    id: 'b9',
    title: 'Trend Following Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.trending_up,
    overview: 'Trend following is based on the principle that assets in motion tend to stay in motion. In crypto, this means identifying coins in strong uptrends and riding them until structural change.',
    marketConditions: [
      'Bull market cycles',
      'Consistent higher highs/higher lows'
    ],
    entryRules: [
      'Identify an uptrend using the 50/200 EMA or trendlines.',
      'Enter on pullbacks or breakouts in the trend direction.',
      'Hold as long as the trend structure remains intact.'
    ],
    stopLoss: 'Trailed below the most recent swing low.',
    takeProfit: 'Exit when the trend structure finally breaks.',
    example: r'You buy a Layer 2 token and hold it for 3 months as it follows the bull trend.',
    commonMistakes: [
      'Exiting prematurely during a healthy retracement.',
      'Distinguishing a retracement from a true reversal too late.',
    ],
    practiceTask: 'Find a coin above its 200 EMA and observe its behavior on pullbacks.',
  ),
  StrategyLesson(
    id: 'b10',
    title: 'Bollinger Bands Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.align_horizontal_center,
    overview: 'Bollinger Bands consist of a middle MA with upper/lower bands 2 standard deviations away. This strategy uses the "Squeeze" and "Band Bounce" to time entries.',
    marketConditions: [
      'Low volatility consolidation (Squeeze)',
      'Ranging markets (Bounce)'
    ],
    entryRules: [
      'Squeeze: Buy/sell when price breaks out of narrow bands with volume.',
      'Bounce: Buy when price touches lower band in a range with confirmation.',
      'Enter on the signal candle close.'
    ],
    stopLoss: 'Beyond the band or break point.',
    takeProfit: 'The middle band or opposite balance.',
    example: r'Bands tighten for a week. A high-volume candle breaks the upper band. You buy.',
    commonMistakes: [
      'Shorting just because price touched the upper band in a strong trend.',
      'Trading the bounce during a volatile breakout.',
    ],
    practiceTask: 'Find a coin where the Bollinger Bands are "squeezing" tightly.',
  ),
  StrategyLesson(
    id: 'b11',
    title: 'MACD Crossover Strategy',
    level: StrategyLevel.beginner,
    icon: Icons.compare_arrows,
    overview: 'The MACD is a momentum indicator that generates signals when its lines cross. It helps identify shifts in momentum before they are fully visible in price.',
    marketConditions: [
      'Trending markets',
      'Emerging momentum'
    ],
    entryRules: [
      'Buy when MACD line crosses ABOVE the signal line.',
      'Sell/Short when MACD line crosses BELOW the signal line.',
      'Enter on the candle completing the crossover.'
    ],
    stopLoss: 'Recent swing high or low.',
    takeProfit: 'Next key level or opposite MACD crossover.',
    example: r'MACD line crosses up below the zero line on the 4H chart. You buy.',
    commonMistakes: [
      'Trading crossovers in a sideways high-noise market.',
      'Ignoring the histogram which can signal slowing momentum early.',
    ],
    practiceTask: 'Add MACD to your chart and identify the last bullish crossover on the 1D timeframe.',
  ),

  // INTERMEDIATE STRATEGIES (7)
  StrategyLesson(
    id: 'i1',
    title: 'Moving Average Crossover Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.waves,
    overview: 'Moving averages smooth out price action and help identify the direction of the trend. The Moving Average Crossover Strategy uses two moving averages — typically a fast one (e.g., 20 EMA) and a slow one (e.g., 50 EMA) — and generates trade signals when they cross.',
    marketConditions: [
      'Trending markets',
      'Consistent momentum moves'
    ],
    entryRules: [
      'Fast MA (20 EMA) crosses above slow MA (50 EMA) = Golden Cross (Buy).',
      'Fast MA (20 EMA) crosses below slow MA (50 EMA) = Death Cross (Sell/Short).',
      'Enter on the candle close after the crossover.'
    ],
    stopLoss: 'Placed below the slow MA.',
    takeProfit: 'Next resistance level or a multiple of the risk taken.',
    example: r'The 20 EMA crosses above the 50 EMA on the 4H chart. You buy at the close.',
    commonMistakes: [
      'Trading crossovers in sideways "chop" (sideways markets).',
      'Entering too late once the crossover is overextended.',
    ],
    practiceTask: 'Set up 20 and 50 EMA on your chart and identify the last three crossovers.',
  ),
  StrategyLesson(
    id: 'i2',
    title: 'RSI Reversal Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.show_chart,
    overview: 'The Relative Strength Index (RSI) measures speed and magnitude of price changes (0-100). Readings >70 are overbought; <30 are oversold. This strategy looks for momentum shifts as RSI returns from these extremes.',
    marketConditions: [
      'Overextended trends',
      'Extreme price exhaustion'
    ],
    entryRules: [
      'Wait for RSI to enter an extreme zone (<30 or >70).',
      'Wait for RSI to cross back out of that zone as a trigger.',
      'Enter on the candle that triggers the crossback.'
    ],
    stopLoss: 'Recent swing low (longs) or swing high (shorts).',
    takeProfit: 'Opposite RSI extreme or a key price level.',
    example: r'RSI drops to 20, then crosses back above 30. You buy at the close.',
    commonMistakes: [
      'Trading RSI extremes alone without price confirmation.',
      'Ignoring divergence where price keeps falling despite RSI rising.',
    ],
    practiceTask: 'Find a coin where RSI recently crossed back from below 30.',
  ),
  StrategyLesson(
    id: 'i3',
    title: 'Volume Breakout Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.bar_chart,
    overview: 'Volume is the ultimate indicator of conviction. This strategy focuses on breakouts accompanied by a surge (1.5x-2x average), confirming that large participants are behind the move.',
    marketConditions: [
      'Key level breaks (S/R)',
      'High institutional participation'
    ],
    entryRules: [
      'Identify a breakout above resistance or below support.',
      'Ensure volume is at least 1.5x to 2x the recent average.',
      'Enter on the breakout candle close or retest.'
    ],
    stopLoss: 'Just below/above the breakout point.',
    takeProfit: 'Projected price extensions based on range height.',
    example: r'Resistance at $50 breaks with 3x average volume. You buy at $50.50.',
    commonMistakes: [
      'Trading low-volume breakouts (likely fakeouts).',
      'Assuming volume is high when it is just seasonal / average.',
    ],
    practiceTask: 'Add Volume to your indicators and compare breakout candles to average volume bars.',
  ),
  StrategyLesson(
    id: 'i4',
    title: 'Multi-Timeframe Trading Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.timer,
    overview: 'Analyzing a cryptocurrency on multiple timeframes — higher for direction and lower for entry. Trade with the higher trend, enter on the lower setup.',
    marketConditions: [
      'Clear direction on Daily/4H charts',
      'Alignment across multiple intervals'
    ],
    entryRules: [
      'Use the Daily chart to identify trend and key levels.',
      'Drop to the 4H or 1H chart to find a precise setup.',
      'Enter when all timeframes align in the same direction.'
    ],
    stopLoss: 'Placed based on the lower timeframe structure.',
    takeProfit: 'Next resistance/support on the Daily chart.',
    example: r'Daily trend is UP. 4H hits support. 1H shows a reversal candle. You buy.',
    commonMistakes: [
      'Ignoring the higher timeframe bias entirely.',
      'Getting distracted by noise on very low timeframes (1m/5m).',
    ],
    practiceTask: 'Look at BTC on 1D, 4H, and 1H. Are they all in the same trend phase?',
  ),
  StrategyLesson(
    id: 'i5',
    title: 'Support Turned Resistance Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.swap_vert,
    overview: 'A "flip zone" occurs when a broken level swaps roles due to market memory. Traders who bought at a support level sell to break even when price rallies back to it from below.',
    marketConditions: [
      'Recently broken structural levels',
      'Role-swap price action'
    ],
    entryRules: [
      'Identify a clearly broken support level.',
      'Wait for price to rally back and retest that level from below.',
      'Enter short when a bearish confirmation candle forms at the flip zone.'
    ],
    stopLoss: 'Placed above the flip zone.',
    takeProfit: 'Next support level below.',
    example: r'BTC breaks $50k support. It rallies back to $50k and rejects. You short.',
    commonMistakes: [
      'Entering short before price actually retests the level.',
      'Thinking the level will always hold without a rejection candle.',
    ],
    practiceTask: 'Find a recent chart where a resistance level was broken and became support.',
  ),
  StrategyLesson(
    id: 'i6',
    title: 'Fibonacci Retracement Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.straighten,
    overview: 'Fibonacci levels (38.2%, 50%, 61.8%) indicate where price may pause during a pullback. The 61.8% "Golden Ratio" is the most watched in crypto.',
    marketConditions: [
      'Impulse moves followed by pullbacks',
      'Trending markets'
    ],
    entryRules: [
      'Draw Fib from swing low to swing high (in uptrend).',
      'Wait for price to pull back into a key zone (0.5 or 0.618).',
      'Enter on a confirmation candle at the Fib level.'
    ],
    stopLoss: 'Below the next Fib level or swing low.',
    takeProfit: 'Prior swing high or extension levels.',
    example: r'Price pulls back exactly to the 0.618 level and bounces. You buy.',
    commonMistakes: [
      'Using Fib on non-trending charts.',
      'Ignoring horizontal S/R that could overlap with Fib (confluence).',
    ],
    practiceTask: 'Draw a Fibonacci Retracement on the most recent 1D pump of Ethereum.',
  ),
  StrategyLesson(
    id: 'i7',
    title: 'Momentum Trading Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.speed,
    overview: 'Momentum trades ride explosive trends. Cryptocurrencies moving strongly tend to continue while volume rises and bullish candles stack.',
    marketConditions: [
      'Accelerating trends',
      'High relative strength vs market'
    ],
    entryRules: [
      'Identify tokens making new highs with increasing volume.',
      'Enter on a breakout above local highs or a brief 10/20 EMA pullback.',
      'Cut losses quickly if momentum stalls.'
    ],
    stopLoss: 'Below the most recent swing low or moving average.',
    takeProfit: 'Key resistance levels or using a trailing stop.',
    example: r'A coin is up 20% on huge volume. You buy the first 5-minute flag breakout.',
    commonMistakes: [
      'Buying at the very peak of a vertical pump (FOMO).',
      'Holding when weight and volume start dropping off.',
    ],
    practiceTask: 'Check the "Top Gainers" and check if their volume is still increasing.',
  ),
  StrategyLesson(
    id: 'i8',
    title: 'Scalping Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.timer_outlined,
    overview: 'Scalping is a high-frequency trading style that capture small profits from minor moves in seconds to minutes. It requires tight spreads, rapid execution, and high discipline.',
    marketConditions: [
      'High liquidity (BTC, ETH)',
      'Tight bid-ask spreads'
    ],
    entryRules: [
      'Operate on 1m to 5m charts.',
      'Target moves of 0.2% to 1%.',
      'Use level 2 order book or short-term momentum signals.'
    ],
    stopLoss: 'Extremely tight (0.1% to 0.3%).',
    takeProfit: 'Small, frequent targets.',
    example: r'You scalp 0.5% profit on BTC in 3 minutes during a volatility spike.',
    commonMistakes: [
      'Allowing fees to erode all profits.',
      'Losing discipline and "revenge trading" after a loss.',
    ],
    practiceTask: 'Try to identify 3 potential "scalp" entries on the 1m chart during active hours.',
  ),
  StrategyLesson(
    id: 'i9',
    title: 'Mean Reversion Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.auto_graph,
    overview: 'Mean reversion assumes price returns to its average after extreme moves. Stretching too far from the 20 or 50 EMA often leads to a "snap back" move.',
    marketConditions: [
      'Range-bound or consolidating markets',
      'Overextended price action'
    ],
    entryRules: [
      'Identify price stretched far from the 20 or 50 EMA.',
      'Check if RSI is at an extreme overbought/oversold reading.',
      'Enter after the first confirmation candle back toward the mean.'
    ],
    stopLoss: 'Placed beyond the extreme stretch wick.',
    takeProfit: 'The moving average (mean) itself.',
    example: r'Price is 10% below the 50 EMA and RSI is at 15. You buy the reversal.',
    commonMistakes: [
      'Trading mean reversion during a massive structural trend (price stays stretched).',
      'Entering before a reversal candle confirms the turn.',
    ],
    practiceTask: 'Find the 50 EMA on the Daily chart and see how often price returns to it.',
  ),
  StrategyLesson(
    id: 'i10',
    title: 'VWAP Trading Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.bar_chart_outlined,
    overview: 'VWAP is the daily average price weighted by volume. It represents institutional "fair value" and acts as a dynamic support/resistance that resets daily.',
    marketConditions: [
      'Intraday trading sessions',
      'High-volume periods'
    ],
    entryRules: [
      'Buy when price pulls back to VWAP from above (support).',
      'Short when price rallies to VWAP from below (resistance).',
      'Enter on a confirmation candle at the VWAP touch.'
    ],
    stopLoss: 'Placed just beyond the VWAP level.',
    takeProfit: 'Prior high or low of the session.',
    example: r'Price touches the VWAP line and forms a pin bar. You buy.',
    commonMistakes: [
      'Ignoring VWAP on higher timeframes (it is mostly an intraday level).',
      'Trading the first touch of a very young VWAP line (Wait for volume to build).',
    ],
    practiceTask: 'Add VWAP to your 15m chart and watch how price reacts at its touch.',
  ),
  StrategyLesson(
    id: 'i11',
    title: 'Divergence Trading Strategy',
    level: StrategyLevel.intermediate,
    icon: Icons.difference_outlined,
    overview: 'Divergence occurs when price and momentum (RSI/MACD) move in opposite directions, signaling weakening trend strength and a potential reversal.',
    marketConditions: [
      'Mature trends showing exhaustion',
      'Key support/resistance levels'
    ],
    entryRules: [
      'Bullish: Price makes Lower Low, RSI makes Higher Low.',
      'Bearish: Price makes Higher High, RSI makes Lower High.',
      'Enter after a reversal candle confirms the divergence.'
    ],
    stopLoss: 'Beyond the price extreme that formed the divergence.',
    takeProfit: 'Next major structural level.',
    example: r'ETH hits a new high, but RSI is lower than the last peak. You short.',
    commonMistakes: [
      'Thinking every divergence leads to a reversal (it can lead to sideways chop).',
      'Confusing regular (reversal) vs hidden (continuation) divergence.',
    ],
    practiceTask: 'Find one bullish and one bearish divergence on the 4H chart.',
  ),

  // ADVANCED STRATEGIES (6)
  StrategyLesson(
    id: 'a1',
    title: 'Liquidity Sweep Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.cleaning_services,
    overview: 'Liquidity refers to clusters of stop-loss and pending orders at predictable levels (above highs/below lows). Institutions push price into these zones to fill large orders before reversing.',
    marketConditions: [
      'High-volume news releases',
      'Market opens',
      'Established ranges'
    ],
    entryRules: [
      'Identify equal highs (buy stops) or equal lows (sell stops).',
      'Wait for price to sweep through that level and immediately reject.',
      'Enter after the sweep candle closes back inside the prior range.'
    ],
    stopLoss: 'Placed beyond the extreme sweep wick.',
    takeProfit: 'Opposing liquidity pool on the other side of the range.',
    example: r'BTC drops below $55k lows, triggers all stops, and closes back above $55.2k.',
    commonMistakes: [
      'Trading what looks like a sweep but is actually a real breakout.',
      'Entering before the sweep candle actually closes.',
    ],
    practiceTask: 'Find "equal lows" on a 15m chart and wait for a wick to pierce and reject them.',
  ),
  StrategyLesson(
    id: 'a2',
    title: 'Market Structure Break Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.architecture,
    overview: 'Market structure is the pattern of swing points (HH/HL/LH/LL). A Market Structure Break (MSB) occurs when price closes beyond a key swing point, signaling a trend change.',
    marketConditions: [
      'Potential trend reversals',
      'Transition from ranging to trending'
    ],
    entryRules: [
      'Identify the current trend structure (HH/HL).',
      'Watch for a decisive candle close breaking a key higher low (downside MSB).',
      'Enter on the retest of the broken structural level.'
    ],
    stopLoss: 'Placed beyond the break point.',
    takeProfit: 'Next major structural level in the new direction.',
    example: r'After an uptrend, price closes below the last HL. You short the retest.',
    commonMistakes: [
      'Confusing a "stop hunt" or wick for a structural break.',
      'Entering without a retest (chasing the break).',
    ],
    practiceTask: 'Mark HH/HL on an uptrend and identify the candle that breaks the HL.',
  ),
  StrategyLesson(
    id: 'a3',
    title: 'Order Block Trading Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.layers,
    overview: 'An order block is the last candle before a massive impulse move, representing institutional order clusters. Institutions often return to these zones to add to positions.',
    marketConditions: [
      'Institutional-driven price action',
      'Post-impulse retracements'
    ],
    entryRules: [
      'Mark the last down candle before a massive up-move (Bullish OB).',
      'Wait for price to return (pull back) into that specific OB zone.',
      'Enter on a confirmation candle within the block.'
    ],
    stopLoss: 'Placed below the order block low.',
    takeProfit: 'High of the impulse move that created the block.',
    example: r'A big red candle at $30k precedes a $5k pump. You buy when price retests $30k.',
    commonMistakes: [
      'Using old blocks that have already been retested (mitigated).',
      'Ignoring the broader market trend.',
    ],
    practiceTask: 'Find a strong impulse move and identify the "OB" candle that started it.',
  ),
  StrategyLesson(
    id: 'a4',
    title: 'Confluence Trading Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.join_inner,
    overview: 'Confluence is the alignment of multiple independent technical factors (S/R, Fib, EMAs) at one level. Overlap increases probability.',
    marketConditions: [
      'High-probability turning points',
      'Alignment of multiple indicators'
    ],
    entryRules: [
      'Map out multiple technical tools (S/R, Fib, Trendlines).',
      'Identify zones where 2 or more separate signals overlap.',
      'Enter at the confluence zone with a confirmation candle.'
    ],
    stopLoss: 'Placed beyond the furthest confluence factor.',
    takeProfit: 'Next significant level with no opposing confluence.',
    example: r'Fib 61.8% + daily support + 200 EMA all meet at $40. You buy.',
    commonMistakes: [
      'Over-complicating (waiting for 10 factors that never meet).',
      'Thinking confluence makes a trade "risk-free".',
    ],
    practiceTask: 'Find a recent trade setup that had at least 3 distinct technical reasons.',
  ),
  StrategyLesson(
    id: 'a5',
    title: 'News Volatility Trading Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.newspaper,
    overview: 'Crypto is sensitive to news (ETF, hacks, Fed). This strategy handles the extreme volatility surrounding these events.',
    marketConditions: [
      'High-impact news announcements',
      'Immediate post-news volatility'
    ],
    entryRules: [
      'Identify key S/R levels near price BEFORE the event.',
      'Wait for the initial spike to exhaust (never chase the first 1-minute candle).',
      'Enter on the retest of support/resistance formed by the spike.'
    ],
    stopLoss: 'Initial news high/low or structural invalidation.',
    takeProfit: 'Scalp targets or next major Daily levels.',
    example: r'ETF news hits, price spikes 10% and retraces 3%. You buy the support.',
    commonMistakes: [
      'Chasing the initial spike candle (spread and slippage are fatal).',
      'Trading without significantly reducing position size.',
    ],
    practiceTask: 'Look at the 1m chart during a past Fed rate announcement.',
  ),
  StrategyLesson(
    id: 'a6',
    title: 'Risk-Reward Based Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.balance,
    overview: 'Risk-reward is a framework to ensure mathematical expectancy. Targeting 1:3 RR means risking \$100 to make \$300.',
    marketConditions: [
      'Every trade setup',
      'Mathematical profitability focus'
    ],
    entryRules: [
      'Never take a trade with less than 1:2 risk-reward.',
      'Identify entry and place stop at a logical technical point.',
      'Target at least 2-3 times the stop distance; skip if not possible.'
    ],
    stopLoss: 'Logical technical invalidation point.',
    takeProfit: 'Strictly at 2x or 3x the risk mark.',
    example: r'Risk $10 to make $30. Even a 30% win rate is profitable.',
    commonMistakes: [
      'Cutting winners too early before the target is hit.',
      'Widening stops or "averaging down" on losers.',
    ],
    practiceTask: 'Calculate your profit after 10 trades: 7 losses, 3 wins at 1:4 RR.',
  ),
  StrategyLesson(
    id: 'a7',
    title: 'Fake Breakout Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.cancel_outlined,
    overview: 'A fake breakout occurs when price breaks a key level, triggers stops, and then reverses sharply. instead of trading the breakout, you trade the failure of the breakout.',
    marketConditions: [
      'Key levels with obvious stops',
      'High manipulation environments'
    ],
    entryRules: [
      'Identify a key level with obvious liquidity.',
      'Wait for price to break that level and then close back inside the prior range.',
      'Enter on the candle that closes back inside.'
    ],
    stopLoss: 'Placed beyond the fakeout wick high or low.',
    takeProfit: 'The opposite side of the range.',
    example: r'Price spikes above resistance at $60k, then drops to $59.5k. You short.',
    commonMistakes: [
      'Trading against a breakout that has real sustained momentum.',
      'Entering before price has closed back inside the range.',
    ],
    practiceTask: 'Look for a "failed" Breakout on the 15m chart and mark the fakeout wick.',
  ),
  StrategyLesson(
    id: 'a8',
    title: 'Smart Money Concept Strategy',
    level: StrategyLevel.advanced,
    icon: Icons.auto_awesome,
    overview: 'SMC models the behavior of institutions and market makers. It uses order blocks, gaps, and liquidity sweeps into a unified high-probability framework.',
    marketConditions: [
      'Institutional order flows',
      'Structural trend transitions'
    ],
    entryRules: [
      'Identify the HTF trend using market structure.',
      'Locate a significant order block and wait for a liquidity sweep.',
      'Enter on a LTF structure break within the order block zone.'
    ],
    stopLoss: 'Placed below/above the order block.',
    takeProfit: 'The next major liquidity pool.',
    example: r'After a sweep of lows, price hits a daily OB and breaks 15m structure. You buy.',
    commonMistakes: [
      'Ignoring higher timeframe context.',
      'Over-complicating with too many minor "internal" structure breaks.',
    ],
    practiceTask: 'Watch a video on "Change of Character (CHOCH)" and find one example on your chart.',
  ),
];

// Helper to get structured groups
Map<StrategyLevel, List<StrategyLesson>> get groupedStrategies {
  final map = {
    StrategyLevel.beginner: <StrategyLesson>[],
    StrategyLevel.intermediate: <StrategyLesson>[],
    StrategyLevel.advanced: <StrategyLesson>[],
  };
  for (var s in mockStrategies) {
    map[s.level]?.add(s);
  }
  return map;
}
