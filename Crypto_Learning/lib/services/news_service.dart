import '../models/news.dart';

class NewsService {
  NewsService();

  Future<List<NewsModel>> getLatestNews() async {
    await Future.delayed(const Duration(milliseconds: 600));

    final mockJsonList = [
      {
        "title":
            "Bitcoin Surges Past \$70K: Analysts Eye New All-Time High as Institutional Demand Soars",
        "domain": "coindesk.com",
        "url": "https://coindesk.com",
        "published_at": DateTime.now()
            .subtract(const Duration(minutes: 8))
            .toIso8601String(),
      },
      {
        "title":
            "Ethereum Layer 2 Ecosystem Hits \$50B TVL Milestone, Marking New Era of Scalability",
        "domain": "cointelegraph.com",
        "url": "https://cointelegraph.com",
        "published_at": DateTime.now()
            .subtract(const Duration(minutes: 25))
            .toIso8601String(),
      },
      {
        "title":
            "Federal Reserve Signals Possible Rate Cuts â€” What It Means for Crypto Markets",
        "domain": "decrypt.co",
        "url": "https://decrypt.co",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 1))
            .toIso8601String(),
      },
      {
        "title":
            "Solana Breaks 500M Transaction Record in 24 Hours, Network Proves Resilience",
        "domain": "cryptoslate.com",
        "url": "https://cryptoslate.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
      },
      {
        "title":
            "BlackRock Bitcoin ETF Now Holds Over 500,000 BTC â€” Becoming Third Largest BTC Holder",
        "domain": "theblock.co",
        "url": "https://theblock.co",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 3))
            .toIso8601String(),
      },
      {
        "title":
            "SEC Approves First Spot Ethereum ETF in Landmark Decision for the Crypto Industry",
        "domain": "reuters.com",
        "url": "https://reuters.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 4))
            .toIso8601String(),
      },
      {
        "title":
            "DeFi Protocol Hits \$10B in Weekly Volume as Onchain Activity Surges",
        "domain": "defipulse.com",
        "url": "https://defipulse.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 5))
            .toIso8601String(),
      },
      {
        "title":
            "Binance Launches New Trading Features Including Grid Bot and Auto-Invest",
        "domain": "binance.com",
        "url": "https://binance.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 6))
            .toIso8601String(),
      },
      {
        "title":
            "Top Analyst: Altcoin Season Could Begin Within Weeks as Bitcoin Dominance Peaks",
        "domain": "ambcrypto.com",
        "url": "https://ambcrypto.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 7))
            .toIso8601String(),
      },
      {
        "title":
            "El Salvador Reports \$40M+ Bitcoin Profit as Country's Strategy Proves Successful",
        "domain": "coindesk.com",
        "url": "https://coindesk.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 9))
            .toIso8601String(),
      },
      {
        "title":
            "Tether USDT Market Cap Crosses \$120B â€” Stablecoin Demand at All-Time High",
        "domain": "cointelegraph.com",
        "url": "https://cointelegraph.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 11))
            .toIso8601String(),
      },
      {
        "title":
            "Chainlink Surges 20% After Major Financial Institution Integration Announced",
        "domain": "decrypt.co",
        "url": "https://decrypt.co",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 14))
            .toIso8601String(),
      },
      {
        "title":
            "Crypto Market Cap Returns to \$3 Trillion as Bull Run Sentiment Dominates",
        "domain": "coingecko.com",
        "url": "https://coingecko.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 16))
            .toIso8601String(),
      },
      {
        "title":
            "MicroStrategy Purchases Additional 5,000 BTC, Total Holdings Now 400,000 BTC",
        "domain": "bitcoinmagazine.com",
        "url": "https://bitcoinmagazine.com",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 18))
            .toIso8601String(),
      },
      {
        "title":
            "Web3 Gaming Sector Raises \$500M in Q1 2026 as Blockchain Gaming Goes Mainstream",
        "domain": "nftinsider.io",
        "url": "https://nftinsider.io",
        "published_at": DateTime.now()
            .subtract(const Duration(hours: 22))
            .toIso8601String(),
      },
    ];

    return mockJsonList.map((j) => NewsModel.fromJson(j)).toList();
  }
}
