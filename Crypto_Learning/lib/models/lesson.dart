import 'resource.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

class LessonModel {
  final String id;
  final String phaseId;
  final String phase;
  final String title;
  final String content;
  final String duration;
  final String difficulty;
  final List<ResourceModel> resources;
  final List<QuizQuestion> quizzes;

  LessonModel({
    required this.id,
    required this.phaseId,
    required this.phase,
    required this.title,
    required this.content,
    this.duration = '5 min',
    this.difficulty = 'Beginner',
    this.resources = const [],
    this.quizzes = const [],
  });
}

final mockLessons = [
  LessonModel(
    id: 'f1',
    phaseId: 'foundations',
    phase: 'Foundations',
    title: 'What is Cryptocurrency',
    duration: '6 min',
    difficulty: 'Beginner',
    content: r'''**Overview**
Cryptocurrency is a digital form of money secured by cryptography, making it nearly impossible to counterfeit. It operates on decentralized networks without a central authority like a bank.

![Crypto Ecosystem](https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&q=80&w=800)

**Core Concept**
Unlike traditional fiat money controlled by governments, cryptocurrencies use blockchain technology—a distributed public ledger enforced by a network of computers. This allows for peer-to-peer transactions globally, 24/7, without intermediaries. The transactions are immutable, meaning they cannot be reversed or altered.

**Real Market Example**
Imagine sending money to a friend in another country. A bank might take days and charge high fees. With Bitcoin or a stablecoin (like USDT), the transfer happens in minutes with minimal fees, directly from your wallet to theirs, without needing their permission.

**Chart Explanation**
When looking at a crypto chart, you're seeing the real-time valuation of these decentralized assets against another asset, usually US Dollars (USD) or Tether (USDT). The charts never close, unlike traditional stock market charts which close on weekends.

**Common Beginner Mistakes**
Storing large amounts of crypto on centralized exchanges instead of a private hardware wallet.
Losing the recovery "seed phrase" which permanently locks you out of your funds.
Buying a coin just because the per-coin price is "cheap" without looking at its total market cap.

**Professional Insight**
Experienced traders treat Bitcoin as the "index" of the crypto market. If Bitcoin trends down, it typically pulls the rest of the market (altcoins) down with it. Always analyze Bitcoin before analyzing smaller coins.

**Practice Task**
Open the Market tab and compare the price of Bitcoin (BTC) to another asset like Ethereum (ETH). Observe how the prices move constantly.

**Quick Summary**
Crypto is decentralized digital money. It enables borderless, trustless transactions and operates 24/7. Always protect your keys.''',
    resources: [
      ResourceModel(
        id: 'r1',
        type: ResourceType.article,
        title: 'What is Cryptocurrency?',
        description:
            'Read the comprehensive guide to the basics of cryptocurrency.',
        url: 'https://www.investopedia.com/terms/c/cryptocurrency.asp',
      ),
      ResourceModel(
        id: 'r2',
        type: ResourceType.video,
        title: 'Cryptocurrency Explained',
        description: 'A 5-minute animated explainer on how crypto works.',
        url: 'https://www.youtube.com/watch?v=1YyAzVmP9xQ',
      ),
    ],
    quizzes: [
      const QuizQuestion(
        question: 'What technology underlies most cryptocurrencies?',
        options: ['Cloud Storage', 'Blockchain', 'Central Banking'],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'Which of the following is true about crypto markets?',
        options: [
          'They close on weekends',
          'They are controlled by the Federal Reserve',
          'They trade 24/7',
        ],
        correctOptionIndex: 2,
      ),
      const QuizQuestion(
        question: 'Why do traders monitor Bitcoin even if trading other coins?',
        options: [
          'Because Bitcoin controls the internet',
          'Because Bitcoin often dictates the general market trend',
          'Because altcoins are illegal',
        ],
        correctOptionIndex: 1,
      ),
    ],
  ),
  LessonModel(
    id: 'f2',
    phaseId: 'foundations',
    phase: 'Foundations',
    title: 'How Trading Charts Work',
    duration: '8 min',
    difficulty: 'Beginner',
    content: r'''**Overview**
Trading charts are the visual representation of historical price action. Learning to read them is the first step in technical analysis.

![Trading Charts](https://images.unsplash.com/photo-1611974714014-419b136261c3?auto=format&fit=crop&q=80&w=800)

**Core Concept**
A chart plots price on the vertical axis (Y) against time on the horizontal axis (X). While line charts just connect closing prices, professional traders use "candlestick" charts to see exactly what happened during a specific time period.

**Real Market Example**
If you look at the 1-hour chart of Ethereum, every single data point represents exactly 60 minutes of trading. You can quickly see whether buyers or sellers dominated that hour.

**Chart Explanation**
The chart consists of the main price window and often a volume window underneath it. Timeframes can be adjusted from 1 minute (1m) for day trading, to 1 day (1D) or 1 week (1W) for long-term investing.

**Common Beginner Mistakes**
Zooming in too much (e.g., trading the 1m chart) and panicking over tiny price movements.
Ignoring the overall long-term trend while focusing only on the short-term chart.
Overcomplicating the chart with too many indicators to the point where the price is invisible.

**Professional Insight**
"Trend is your friend until the end when it bends." Professionals always start their analysis on higher timeframes (Daily or Weekly) to find the macro trend before zooming into lower timeframes (4-Hour or 1-Hour) to find an entry.

**Practice Task**
Open the Ethereum (ETHUSDT) chart. Switch between the 15-minute, 1-hour, and 1-day timeframes to see how the trend looks completely different depending on your perspective.

**Quick Summary**
Charts visually represent price over time. Always start your analysis on higher timeframes to understand the big picture before zooming in.''',
    quizzes: [
      const QuizQuestion(
        question: 'What does the Y-axis represent on a trading chart?',
        options: ['Time', 'Price', 'Volume'],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question:
            'Why do professionals check the daily chart before the 15-minute chart?',
        options: [
          'To find the macro trend first',
          'Because the daily chart updates faster',
          'To calculate their taxes',
        ],
        correctOptionIndex: 0,
      ),
      const QuizQuestion(
        question: 'What is a common mistake beginners make with charts?',
        options: [
          'Using a mouse to click',
          'Zooming in too much and panicking over noise',
          'Looking at the price',
        ],
        correctOptionIndex: 1,
      ),
    ],
  ),
  LessonModel(
    id: 'f3',
    phaseId: 'foundations',
    phase: 'Foundations',
    title: 'Candlestick Basics',
    duration: '10 min',
    difficulty: 'Beginner',
    content: r'''**Overview**
Japanese Candlesticks show the open, high, low, and close prices for a specific time period. They are the standard way traders view price action.

![Candlestick Anatomy](https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?auto=format&fit=crop&q=80&w=800)

**Core Concept**
Each candle has a "body" and "wicks" (or shadows). 
**Green/White Candle:** The close was higher than the open (Bullish).
**Red/Black Candle:** The close was lower than the open (Bearish).
**Wicks:** The highest and lowest prices reached during that time period.

**Real Market Example**
A green candle on a 1H chart means buyers pushed the price up over that hour. A long lower wick means sellers tried to push the price down, but buyers stepped in aggressively and pushed it back up before the hour ended.

**Chart Explanation**
A chart is just a sequence of these candlesticks. A large green body indicates strong buying pressure, while a large red body indicates strong selling pressure. Small bodies (Doji) indicate indecision.

**Common Beginner Mistakes**
Trying to memorize 50 different candlestick patterns instead of understanding the psychology behind the candle.
Trading a pattern before the candle has actually closed. A candle can completely change in the last 10 seconds!
Ignoring context; a bullish candle in a massive downtrend isn't enough to buy.

**Professional Insight**
Wicks equal rejection. A massive wick at the top of a candle means the market rejected higher prices—often a strong signal the price is about to reverse downward.

**Practice Task**
Find a chart and look for a "Hammer" candle (small body at the top, very long lower wick). See if the price reversed upward after that candle.

**Quick Summary**
Candlesticks tell a story of the battle between buyers and sellers. The body shows who won the period, and the wicks show where price was rejected.''',
    quizzes: [
      const QuizQuestion(
        question: 'What does a green candlestick indicate?',
        options: [
          'Price closed higher than it opened',
          'Price closed lower than it opened',
          'Volume was low',
        ],
        correctOptionIndex: 0,
      ),
      const QuizQuestion(
        question: 'What do the wicks of a candle represent?',
        options: [
          'The opening price',
          'The highest and lowest prices of the period',
          'The next candle\'s prediction',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'Why is it dangerous to trade before a candle closes?',
        options: [
          'The exchange will ban you',
          'The candle\'s shape can drastically change before the time finishes',
          'It uses too much battery',
        ],
        correctOptionIndex: 1,
      ),
    ],
  ),
  LessonModel(
    id: 'ta1',
    phaseId: 'technical',
    phase: 'Technical Analysis',
    title: 'Support and Resistance',
    duration: '12 min',
    difficulty: 'Intermediate',
    content: r'''**Overview**
Support and resistance are the most fundamental concepts in technical analysis. They represent price levels where the market has historically had difficulty breaking through.

![Support and Resistance](https://images.unsplash.com/photo-1620228883747-d536fe803b1a?auto=format&fit=crop&q=80&w=800)

**Core Concept**
**Support:** A "floor" where buying interest is strong enough to overcome selling pressure. Price drops, hits support, and bounces up.
**Resistance:** A "ceiling" where selling interest overcomes buying pressure. Price rises, hits resistance, and gets rejected downward.

**Real Market Example**
If Bitcoin keeps dropping to $60,000 and immediately bouncing back up every time, $60,000 is a strong support level. Buyers believe it's "cheap" at that price and step in.

**Chart Explanation**
You draw horizontal lines across the chart connecting previous price bottoms (to find support) or price tops (to find resistance). When resistance is finally broken upwards, it often becomes the new support level (a "flip").

**Common Beginner Mistakes**
Treating S/R as exact laser-thin lines rather than "zones" or areas.
Buying blindly at support without waiting for bullish confirmation (like a strong green candle).
Shorting exactly at resistance during a massive, euphoric bull run.

**Professional Insight**
The more times a support or resistance level is tested, the WEAKER it gets, not stronger. Imagine hitting a door with a battering ram; eventually, it will break.

**Practice Task**
Open the BTC 1-hour chart and draw two horizontal lines: one connecting the bottoms of recent dips, and one connecting the tops of recent rallies.

**Quick Summary**
Support is where buyers step in (floor), resistance is where sellers step in (ceiling). Old resistance often turns into new support.''',
    resources: [
      ResourceModel(
        id: 'r4',
        type: ResourceType.video,
        title: 'Support and Resistance Explained',
        description: 'Learn how to draw lines and trade the bounce.',
        url: 'https://www.youtube.com/watch?v=WPeE218syd4',
      ),
      ResourceModel(
        id: 'r6',
        type: ResourceType.practice,
        title: 'Chart Practice',
        description:
            'Go to the Bitcoin (BTC) chart and identify the closest support and resistance levels on the 1-hour timeframe.',
      ),
    ],
    quizzes: [
      const QuizQuestion(
        question: 'What is a Support level?',
        options: [
          'A price level where sellers take control',
          'A price level where buyers enter to stop the price from falling',
          'The highest price of the year',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'What usually happens when strong Resistance is broken?',
        options: [
          'It becomes a new Support level',
          'The exchange halts trading',
          'It becomes a stronger Resistance level',
        ],
        correctOptionIndex: 0,
      ),
      const QuizQuestion(
        question: 'How should you treat S/R levels?',
        options: [
          'As exact, to-the-penny price values',
          'As general zones or areas of interest',
          'As guaranteed reversal points',
        ],
        correctOptionIndex: 1,
      ),
    ],
  ),
  LessonModel(
    id: 'ta2',
    phaseId: 'technical',
    phase: 'Technical Analysis',
    title: 'Trendlines',
    duration: '10 min',
    difficulty: 'Intermediate',
    content: r'''**Overview**
Trendlines are diagonal lines drawn on a chart to identify and confirm the direction of a market's trend.

![Trendlines](https://images.unsplash.com/photo-1624996379697-f01d168b1a52?auto=format&fit=crop&q=80&w=800)

**Core Concept**
An uptrend is formed by "Higher Highs and Higher Lows". You draw an ascending trendline by connecting the bottom of the higher lows. A downtrend is "Lower Highs and Lower Lows", and you draw a descending trendline across the tops of the lower highs.

**Real Market Example**
During a bull market, a crypto token might steadily rise over months. Drops will occur, but each drop doesn't fall as low as the previous one. Connecting these dips gives you an ascending trendline.

**Chart Explanation**
The trendline acts as dynamic Support (in an uptrend) or Resistance (in a downtrend). A trader looks for the price to drop and "touch" the ascending trendline before bouncing higher to continue the trend.

**Common Beginner Mistakes**
Forcing a trendline to fit the chart by cutting through the bodies of candlesticks.
Drawing steep, short-term lines and mistaking them for significant macro trends.
Assuming a small wick breaking the line means the entire trend is over.

**Professional Insight**
A valid trendline needs at least three touches. Two points make a line, the third point confirms it. Furthermore, the steeper the trendline, the more unsustainable it is, making it likely to break.

**Practice Task**
Open the Daily chart for Solana (SOL) or Ethereum (ETH) and try to connect the last three major dips with a straight diagonal line.

**Quick Summary**
Trendlines visually map out uptrends and downtrends. Connect higher lows for an uptrend, and lower highs for a downtrend.''',
    quizzes: [
      const QuizQuestion(
        question: 'How do you draw an uptrend line?',
        options: [
          'By connecting the tops of the highs',
          'By connecting the bottoms of the higher lows',
          'By drawing a straight line through the middle of the chart',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'What defines a downtrend?',
        options: [
          'Lower Highs and Lower Lows',
          'Higher Highs and Higher Lows',
          'Equal Highs and Lower Lows',
        ],
        correctOptionIndex: 0,
      ),
      const QuizQuestion(
        question:
            'How many touches does a trendline need to be confirmed valid?',
        options: ['One', 'Two', 'Three'],
        correctOptionIndex: 2,
      ),
    ],
  ),
  LessonModel(
    id: 'ta3',
    phaseId: 'technical',
    phase: 'Technical Analysis',
    title: 'Market Structure',
    duration: '14 min',
    difficulty: 'Advanced',
    content: r'''**Overview**
Market Structure is the holy grail of price action reading. It describes the sequence of highs and lows that dictate whether a market is bullish, bearish, or ranging.

![Market Structure](https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&q=80&w=800)

**Core Concept**
Markets don't move in straight lines; they move in waves. 
**Bullish Structure:** Making Higher Highs (HH) and Higher Lows (HL).
**Bearish Structure:** Making Lower Lows (LL) and Lower Highs (LH).
**Ranging:** Moving sideways between equal highs and equal lows.

**Real Market Example**
If Ethereum goes from $2000 to $2500 (HH), pulls back to $2200 (HL), and rallies to $2800 (HH), the market is in a bullish structure. Traders look to buy the next HL.

**Chart Explanation**
You identify structural breaks, known as a Break of Structure (BOS) or a Change of Character (ChoCh). If a market in a downtrend suddenly rallies and breaks above its previous Lower High, the market structure has shifted from bearish to bullish.

**Common Beginner Mistakes**
Trying to buy the absolute bottom of a downtrend ("catching a falling knife") before the market structure has actually shifted bullish.
Trading aggressively in the middle of a sideways, ranging market.
Viewing structure on a 5-minute chart and ignoring the 4-hour chart structure which is doing the exact opposite.

**Professional Insight**
Professional traders map structure from the top down. If the Weekly chart is bullish, but the 1-Hour chart is bearish, they know the 1-Hour is just a temporary pullback. They wait for the 1-Hour structure to shift back to bullish before buying.

**Practice Task**
Using a 4-hour chart, find a period where the price was trending upwards. Mark the specific "Higher Lows". Find the exact candle where the price dropped below the last 'Higher Low', indicating a structure break.

**Quick Summary**
Market structure tells you who is in control. Trade with the structure, not against it. Wait for sequence shifts before betting on reversals.''',
    quizzes: [
      const QuizQuestion(
        question: 'What constitutes a Bullish Market Structure?',
        options: [
          'Lower Lows and Lower Highs',
          'Higher Highs and Higher Lows',
          'Massive volume spikes',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'What is a Break of Structure (BOS)?',
        options: [
          'When the exchange server crashes',
          'When price breaks past the previous high in an uptrend, or previous low in a downtrend',
          'When a trendline is drawn incorrectly',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question:
            'What is the danger of fighting the higher timeframe market structure?',
        options: [
          'The transaction fees are higher',
          'You are trading against the dominant market momentum',
          'You miss out on dividends',
        ],
        correctOptionIndex: 1,
      ),
    ],
  ),
  LessonModel(
    id: 'ta4',
    phaseId: 'technical',
    phase: 'Technical Analysis',
    title: 'Moving Averages',
    duration: '10 min',
    difficulty: 'Intermediate',
    content: r'''**Overview**
Moving Averages (MA) smooth out price action by calculating the average price over a set number of periods, removing the "noise" to reveal the true trend.

![Moving Averages](https://images.unsplash.com/photo-1526628953301-3e589a6a8b74?auto=format&fit=crop&q=80&w=800)

**Core Concept**
**Simple Moving Average (SMA):** The straight average over X periods.
**Exponential Moving Average (EMA):** Gives more weight to recent prices, making it react faster to new data.
They are used to identify trend direction and potential dynamic support/resistance areas.

**Real Market Example**
A trader might use the 50-day SMA and the 200-day SMA. If the current price is far above both, the market is broadly bullish.

**Chart Explanation**
The MA appears as a curved line that follows the price. Traders often look for "Crossovers." A Golden Cross is when a fast MA (like 50) crosses above a slow MA (like 200). A Death Cross is the opposite.

**Common Beginner Mistakes**
Using MAs in ranging/sideways markets, where they will give constant false "buy" and "sell" crossover signals.
Changing MA lengths constantly to reverse-engineer past trades perfectly, which doesn't work for future data.
Buying purely because of a "Golden Cross" even if the price is already massively overextended.

**Professional Insight**
Institutions heavily monitor the 200-period moving average on the Daily chart. It is widely considered the ultimate dividing line between a macro bull market and a macro bear market.

**Practice Task**
Add a 200-day Simple Moving Average indicator to a Bitcoin Daily chart and observe how the price often reacts violently when it touches it.

**Quick Summary**
MAs smooth out price noise to show the trend. They act as dynamic support and resistance but are lagging indicators, meaning they tell you what happened, not what will happen.''',
    quizzes: [
      const QuizQuestion(
        question: 'What is the difference between an EMA and an SMA?',
        options: [
          'EMA is for stocks, SMA is for crypto',
          'EMA places more weight on recent price action',
          'SMA is a leading indicator',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'What is a "Golden Cross"?',
        options: [
          'When you make 100% profit',
          'When a short-term moving average crosses above a long-term moving average',
          'When price touches the 200 EMA',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'In what market condition do Moving Averages perform poorly?',
        options: [
          'Strong uptrends',
          'Strong downtrends',
          'Sideways ranging markets',
        ],
        correctOptionIndex: 2,
      ),
    ],
  ),
  LessonModel(
    id: 'ta5',
    phaseId: 'technical',
    phase: 'Technical Analysis',
    title: 'Volume Analysis',
    duration: '11 min',
    difficulty: 'Intermediate',
    content: r'''**Overview**
Volume measures the total amount of an asset traded during a specific period. It is the fuel behind price movement.

![Volume Analysis](https://images.unsplash.com/photo-1611948326544-d5c44e05d4c3?auto=format&fit=crop&q=80&w=800)

**Core Concept**
Price action tells you what the market is doing, but Volume tells you how much conviction is behind that movement.
A price breakout on HIGH volume = Genuine interest, likely to continue.
A price breakout on LOW volume = Fakeout, likely to reverse.

**Real Market Example**
A resistance level is broken. Retail traders buy the breakout. However, the volume bars at the bottom of the chart are very small. This means big institutions aren't participating. Shortly after, the price crashes back down.

**Chart Explanation**
Volume is typically displayed as vertical bars at the bottom of the chart. Taller bars mean more trading occurred in that candle structure. 

**Common Beginner Mistakes**
Focusing 100% on candlestick patterns and completely ignoring the volume behind them.
Assuming high red volume always means "downward crash"—often, huge volume spikes at the bottom of a crash represent "capitulation" where the smart money is finally buying up everyone's panic selling.

**Professional Insight**
Professionals look for Volume Divergence. If the price is making Higher Highs but the volume is steadily decreasing with each push up, it signifies exhaustion. The uptrend is running out of gas.

**Practice Task**
Look at the biggest daily crash on a chart over the last year. Note the size of the volume bar on that specific day compared to the days before it.

**Quick Summary**
Volume must confirm the price trend. High volume brings validity to moves and breakouts, while low volume signals weakness and potential fakeouts.''',
    quizzes: [
      const QuizQuestion(
        question:
            'What does it mean if price breaks out of resistance on very low volume?',
        options: [
          'It\'s a highly reliable breakout',
          'It\'s a potential fakeout due to lack of conviction',
          'It means the market has closed',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question:
            'What does decreasing volume during an uptrend often suggest?',
        options: [
          'The trend is losing momentum and may reverse',
          'The trend is getting stronger',
          'Smart money is secretly buying more',
        ],
        correctOptionIndex: 0,
      ),
      const QuizQuestion(
        question: 'Where is volume usually displayed on a chart?',
        options: [
          'As a moving line overlaying the price',
          'As a pie chart',
          'As vertical bars at the bottom of the chart',
        ],
        correctOptionIndex: 2,
      ),
    ],
  ),
  LessonModel(
    id: 'adv1',
    phaseId: 'advanced',
    phase: 'Advanced Trading',
    title: 'Breakout Trading',
    duration: '12 min',
    difficulty: 'Advanced',
    content: r'''**Overview**
Breakout trading involves entering a position as soon as the price moves outside a defined support or resistance area, capitalizing on the explosive momentum that usually follows.

![Breakout Strategy](https://images.unsplash.com/photo-1611948212339-36f1dbed678b?auto=format&fit=crop&q=80&w=800)

**Core Concept**
When price builds up right beneath a heavy resistance level for a long time, tension builds (consolidation). When the price finally breaks through the resistance, all the traders who were shorting get liquidated, and buyers rush in, creating a massive surge.

**Real Market Example**
Bitcoin consolidates between $60,000 and $65,000 for three weeks, forming a tight range. One day, it pushes through $65,000 with huge volume. A breakout trader buys exactly as it crosses $65,100 to catch the surge to $70,000.

**Chart Explanation**
You will see horizontal ranges, triangles, or flags forming on the chart. The moment a solid candle body closes outside these drawn structures, the breakout is confirmed.

**Common Beginner Mistakes**
Buying prematurely before the candle has closed outside the resistance.
Ignoring volume; buying a low-volume breakout that immediately turns into a "bull trap."
Failing to place a strict stop-loss in case the breakout was a fakeout.

**Professional Insight**
Instead of buying the exact moment of the breakout, many professionals wait for the "Retest". The price breaks out, then returns to touch the old resistance (which is now new support). Buying the retest drastically lowers risk.

**Practice Task**
Look back at historical charts and find a "Bull Flag" pattern. See what happened precisely when the price broke the top line of the flag.

**Quick Summary**
Breakouts capitalize on pent-up market momentum snapping through a key level. Always wait for candle closure and volume confirmation to avoid fakeouts.''',
    quizzes: [
      const QuizQuestion(
        question: 'What is the fundamental idea of breakout trading?',
        options: [
          'Buying when the price is at the lowest support',
          'Entering a trade when price pushes through a key level of resistance or support',
          'Trading based on social media rumors',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'What is a "fakeout"?',
        options: [
          'When the price breaks a level but immediately reverses back into the range',
          'A type of candlestick',
          'When the exchange fakes the volume data',
        ],
        correctOptionIndex: 0,
      ),
      const QuizQuestion(
        question: 'Why do professional traders often wait for a "retest"?',
        options: [
          'It confirms the old resistance has flipped to support, lowering risk',
          'Because they are too slow to catch the initial move',
          'Because exchanges freeze during breakouts',
        ],
        correctOptionIndex: 0,
      ),
    ],
  ),
  LessonModel(
    id: 'rm1',
    phaseId: 'risk',
    phase: 'Risk Management',
    title: 'Position Sizing & Risk Management',
    duration: '15 min',
    difficulty: 'Advanced',
    content: r'''**Overview**
Risk management is the only thing that separates professional traders from gamblers. Protecting your capital is vastly more important than making huge profits.

![Risk Management](https://images.unsplash.com/photo-1454165205744-3b78555e5572?auto=format&fit=crop&q=80&w=800)

**Core Concept**
You should never risk more than 1% to 2% of your total account capital on a single trade. This means if your trade hits its Stop Loss, your total portfolio only drops by 1%. 

**Real Market Example**
If you have a $10,000 account, a 1% risk is $100. If you buy Ethereum, and place your Stop Loss 5% below your entry price, you need to calculate exactly how much Ethereum to buy so that a 5% drop equals exactly a $100 loss. Position Size = Risk / Distance to Stop Loss.

**Chart Explanation**
On a chart, you determine the exact price level where your trade idea is "wrong" (e.g., below a major support). That is your Stop Loss. Then you size your position mathematically before entering.

**Common Beginner Mistakes**
Using maximum leverage and risking 20% of their account on a single "sure thing" trade.
Moving their stop loss further down when the price gets close to it, refusing to accept the loss.
Having a 1:0.5 Risk-to-Reward ratio (risking $100 just to make $50).

**Professional Insight**
It is statistically guaranteed that you will face a losing streak. Even the best traders might lose 5 or 6 trades in a row. If you risk 2% per trade, a 5-trade losing streak only draws down your account by 10%. You live to trade another day.

**Practice Task**
Calculate this: If your account is $5,000 and you want to risk 1%, how much money are you allowed to lose on the trade? If your stop loss is 10% away from entry, what is your total position size?

**Quick Summary**
Capital preservation is rule #1. Determine your Stop Loss first, limit your risk to 1-2% of your account, and mathematically calculate your position size.''',
    quizzes: [
      const QuizQuestion(
        question:
            'What is the generally accepted maximum account risk per trade?',
        options: ['10% to 20%', '1% to 2%', '50%'],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'When should you figure out where your Stop Loss will go?',
        options: [
          'After the trade goes into negative profit',
          'As soon as the trade becomes profitable',
          'Before you enter the trade',
        ],
        correctOptionIndex: 2,
      ),
      const QuizQuestion(
        question: 'Why is strict risk management critical?',
        options: [
          'It prevents a losing streak from wiping out your entire account',
          'It guarantees every trade will win',
          'It lowers exchange trading fees',
        ],
        correctOptionIndex: 0,
      ),
    ],
  ),
  LessonModel(
    id: 'rm2',
    phaseId: 'risk',
    phase: 'Risk Management',
    title: 'Trading Psychology',
    duration: '12 min',
    difficulty: 'Advanced',
    content: r'''**Overview**
Trading is 20% strategy and 80% psychology. Your worst enemy in the markets is not the algorithms or the whales—it is your own emotions.

![Trading Psychology](https://images.unsplash.com/photo-1549463599-242446051d02?auto=format&fit=crop&q=80&w=800)

**Core Concept**
The market is a tug-of-war between two main emotions: Greed and Fear. 
**FOMO (Fear Of Missing Out):** Buying at the very top because you see a green candle rocketing up and don't want to miss the profits.
**Panic Selling:** Selling the exact bottom because the pain of seeing red becomes unbearable.

**Real Market Example**
Bitcoin pumps 30% in three days. Mainstream news starts talking about it. A beginner trader feels FOMO and buys heavily at the peak. Institutional traders use that retail liquidity to sell and take profits. The price drops 15%, the beginner panics and sells at a huge loss.

**Chart Explanation**
The massive, euphoric vertical green candles on a daily chart usually signify retail FOMO entering the market. The massive, bleeding red wicks at the bottom represent capitulation.

**Common Beginner Mistakes**
  "Revenge Trading"—taking a random, high-leverage trade immediately after a loss to try and "make it back quickly".
Tying their personal self-worth to their PNL (Profit and Loss).
Looking at their portfolio balance 50 times a day.

**Professional Insight**
Great traders operate like robots. They accept the outcome of a trade the moment they click "Buy", knowing the stop-loss is set. They detach themselves emotionally from the money, treating it strictly as a game of probabilities.

**Practice Task**
Next time you feel a massive urge to buy a coin because it's pumping extremely fast, literally take your hands off the keyboard, close the app, and walk away for 10 minutes.

**Quick Summary**
Control your emotions, or the market will control you. Stick to your logical plan, avoid FOMO, and never revenge trade.''',
    quizzes: [
      const QuizQuestion(
        question: 'What does FOMO stand for?',
        options: [
          'First Option Moving Outside',
          'Fear Of Missing Out',
          'Forward Order Market Operation',
        ],
        correctOptionIndex: 1,
      ),
      const QuizQuestion(
        question: 'What is "Revenge Trading"?',
        options: [
          'Taking immediate impulsive trades to win back money lost on a previous trade',
          'Shorting a coin because you don\'t like the CEO',
          'A highly mathematical algorithmic strategy',
        ],
        correctOptionIndex: 0,
      ),
      const QuizQuestion(
        question: 'How do professional traders view individual trade outcomes?',
        options: [
          'As a reflection of their intelligence',
          'As a life-or-death financial event',
          'Just as one probabilistic event among a large series of trades',
        ],
        correctOptionIndex: 2,
      ),
    ],
  ),
];
